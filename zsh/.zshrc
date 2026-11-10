# ------ exports: generic ------
export DOTFILES_LOCATION="${HOME}/.dotfiles"
export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=vim
export BROWSER=firefox

# ------ path ------
# typeset -U keeps `path` de-duplicated, so re-sourcing this file is idempotent.
typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/go/bin" $path)
export PATH

# ------ exports: aws ------
export AWS_DEFAULT_PROFILE="default"
export AWS_SDK_LOAD_CONFIG=1
export AWS_CONFIG_FILE="${HOME}/.aws/config"

# ------ exports: history ------
HISTSIZE=1048576
SAVEHIST=$HISTSIZE
HISTFILE="${HOME}/.history"

# ------ aliases: directories ------
alias dotfiles="cd $HOME/.dotfiles"
alias personal="cd $HOME/personal"
alias work="cd $HOME/work"

# ------ aliases: kubernetes ------
alias k='kubectl'

# ------ aliases: terraform/tofu ------
alias tf='terraform'
alias tp='terraform plan'
alias ta='terraform apply'
alias tsw='terraform workspace select'

# ------ aliases: miscellaneous ------
# -l : long listing format (detailed info),
# -s : show file size in blocks,
# -A : include hidden files,
# -F : classify file types (/ for dir, * for exec, @ for link, etc.),
# -G : colorize output based on file type
alias ll='ls -lsAFG'

# ------ options: history ------
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history   # implies inc_append_history

# ------ completion ------
# Homebrew-installed completions (kubectl, helm, gh, terraform, argocd, ...).
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
# Rebuild the dump at most once a day; -C skips the security check on the rest.
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''

# Teach the aliases above to complete as their underlying commands.
compdef k=kubectl

# terraform ships a bash-style `complete -C` completer rather than a zsh
# function, so it needs bashcompinit and cannot be driven via compdef.
if (( $+commands[terraform] )); then
  autoload -Uz bashcompinit && bashcompinit
  complete -o nospace -C "${commands[terraform]}" terraform tf
fi

# ------ tmux ------
# ghostty already launches tmux directly; this covers every other terminal.
# Guards: interactive only, not already inside tmux, tmux actually installed,
# real terminal, and NO_AUTO_TMUX=1 as an escape hatch. `exec` means quitting
# tmux ends the terminal instead of dropping to a bare parent shell.
if [[ -o interactive && -z "$TMUX" && -z "$NO_AUTO_TMUX" && "$TERM" != "dumb" ]] \
   && [[ -t 0 && -t 1 ]] && (( $+commands[tmux] )); then
  exec tmux new-session -A -s main
fi

# ------ fzf ------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------ prompt customization ------
setopt PROMPT_SUBST

# `git branch | sed` forks two processes on every prompt; symbolic-ref is one
# builtin git call and stays quiet outside a repository.
parse_git_branch() {
    local ref
    # symbolic-ref is empty on a detached HEAD, so fall back to the short sha.
    ref=$(git symbolic-ref --short HEAD 2>/dev/null) \
      || ref=$(git rev-parse --short HEAD 2>/dev/null) \
      || return
    print -r -- "${ref} "
}

() {
    local user_color="%F{2}"         # palette 2 = #729464 (green - matches selection)
    local host_color="%F{3}"         # palette 3 = #cacaca (bright gray)
    local path_color="%F{2}"         # palette 2 = #729464 (green - matches selection)
    local git_color="%F{3}"          # palette 3 = #cacaca (bright gray)
    local prompt_symbol="%F{7}"      # palette 7 = #dedede (cursor color)
    local reset="%f"

    export PROMPT="${user_color}%n${reset}@${host_color}\${(L)HOST%%.*}${reset} ${path_color}%(2~|%2~|%~)${reset} ${git_color}\$(parse_git_branch)${prompt_symbol}\$${reset} "
}
