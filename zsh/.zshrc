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
alias dotfiles="cd $HOME/dotfiles"
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
alias tp='tofu plan'
alias ta='tofu apply'
alias tsw='tofu select workspace'

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
