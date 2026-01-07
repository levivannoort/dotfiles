# ------ exports: generic ------
export DOTFILES_LOCATION="${HOME}/personal/dotfiles"
export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=vim
export BROSWER=firefox

# ------ exports: miscellaneous ------

# ------ exports: miscellaneous ------
export AWS_DEFAULT_PROFILE="default"
export AWS_SDK_LOAD_CONFIG=1
export AWS_CONFIG_FILE="${HOME}/.aws/config"

# ------ exports: history ------
export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
export HISTFILE="${HOME}/.history"

# ------ aliases: directories ------
alias dotfiles="cd $HOME/.dotfiles"
alias personal="cd $HOME/personal"
alias work="cd $HOME/work"

# ------ aliases: git ------
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gch="git checkout"
alias gaa="git add ."
alias gco="git commit -m"
alias gpl="git pull"
alias gps="git push"

# ------ aliases: kubernetes ------
alias k='kubectl'

# ------ aliases: terraform/tofu ------
alias tf='terraform'
alias tp='terraform plan'
alias ta='terraform apply'
alias tsw='terraform select workspace'

# ------ aliases: miscellaneous ------
# -l : long listing format (detailed info),  -s : show file size in blocks, -A : include hidden files
# -F : classify file types (/ for dir, * for exec, @ for link, etc.), -G : colorize output based on file type
alias ll='ls -lsAFG'

# ------ options: history ------
setopt extended_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt inc_append_history

# ------ tmux ------
if [[ ! $(tmux list-sessions) ]]; then
  tmux
fi

# ------ fzf ------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------ nvm ------
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ------ prompt customization ------
function parse_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      echo "$branch "
    fi
}


COLOR_DEF=$'%f'
COLOR_GIT=$'%F{58}'

setopt PROMPT_SUBST

export PROMPT='%n@${(L)HOST%%.*} %(2~|%2~|%~) ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '
