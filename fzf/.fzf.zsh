# setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# auto-completion
# ---------------
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
