#!/bin/zsh

usage() {
    echo "Usage: $0 [-f file] [-n name1,name2,name3]"
    echo "  -f file    : Read cluster names from a file (one per line)"
    echo "  -n names   : Comma-separated list of cluster names"
    echo "  -h         : Display this help message"
    exit 1
}

declare -A namespace_map=(
    ["cloud-"]="cloud"
    ["edge-"]="edge"
    ["dns-"]="dns"
    ["assets-"]="website"
    ["imagine-"]="imagine"
)

get_namespace() {
    local context_name="$1"
    for prefix in "${(@k)namespace_map}"; do
        if [[ "$context_name" == *${prefix}* ]]; then
            echo "${namespace_map[$prefix]}"
            return
        fi
    done
    echo ""
}

fetch_cluster() {
    local cluster_name="$1"
    echo "Processing cluster: $cluster_name"
    
    # Delete any existing contexts that contain this cluster name
    local existing_contexts=$(kubectl config get-contexts -o name 2>/dev/null | grep "$cluster_name")
    if [[ -n "$existing_contexts" ]]; then
        echo "Removing existing context(s)..."
        echo "$existing_contexts" | while read ctx; do
            kubectl config delete-context "$ctx" >/dev/null 2>&1
        done
    fi
    
    # Fetch the kubeconfig - this creates a context named like "do-region-clustername"
    if ! doctl kubernetes cluster kubeconfig save "$cluster_name"; then
        echo "Failed to fetch kubeconfig for $cluster_name" >&2
        return 1
    fi
    
    # Find the context that was just created (it will contain the cluster name)
    # doctl creates contexts with pattern: do-<region>-<clustername>
    local new_context=$(kubectl config get-contexts -o name 2>/dev/null | grep "$cluster_name" | tail -1)
    
    if [[ -z "$new_context" ]]; then
        echo "Warning: Could not find created context for $cluster_name" >&2
        return 1
    fi
    
    echo "Created context: $new_context"
    
    # Set namespace for the actual context that was created
    local namespace=$(get_namespace "$cluster_name")
    if [[ -n "$namespace" ]]; then
        kubectl config set-context "$new_context" --namespace="$namespace" >/dev/null 2>&1
        echo "✓ Added cluster $cluster_name with namespace '$namespace'"
    else
        echo "✓ Added cluster $cluster_name"
    fi
}

CLUSTER_LIST=()

while getopts "f:n:h" opt; do
    case $opt in
        f)
            if [[ ! -f "$OPTARG" ]]; then
                echo "Error: File '$OPTARG' not found" >&2
                exit 1
            fi
            while IFS= read -r line; do
                [[ -z "$line" || "$line" =~ ^# ]] && continue
                CLUSTER_LIST+=("$line")
            done < "$OPTARG"
            ;;
        n)
            IFS=',' read -rA names <<< "$OPTARG"
            CLUSTER_LIST+=("${names[@]}")
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

if [[ ${#CLUSTER_LIST[@]} -eq 0 ]]; then
    echo "Error: No cluster names provided" >&2
    usage
fi

original_kube_context=$(kubectl config current-context 2>/dev/null)

echo "Fetching DigitalOcean Kubernetes clusters..."

for cluster in "${CLUSTER_LIST[@]}"; do
    echo ""
    fetch_cluster "$cluster"
done

echo ""

# Restore original kubectl context if it still exists
if [[ -n "$original_kube_context" ]]; then
    if kubectl config get-contexts -o name 2>/dev/null | grep -q "^${original_kube_context}$"; then
        echo "Restoring original kubectl context: $original_kube_context"
        kubectl config use-context "$original_kube_context" >/dev/null 2>&1
    else
        echo "Note: Original context no longer exists, staying on last fetched cluster"
    fi
fi

echo "All clusters processed!"
