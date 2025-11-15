{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  stateVersion = "25.05";

  home.packages = with pkgs; [
    jq
    yq
    htop
    vagrant
    packer
    terraform
    opentofu
    tree
    bat
    fzf
    grep
    watch
    sqlite
    kustomize
    helm
    argocd
    kubent
    kubectx
    curl
    redis
    k9s
    k6
    awscli2
    granted
    slides
    goose
    mtr
    gh
    iperf3
    kubectl
    qemu
    libvirt

    go
    lua
    cue
  ]
}
