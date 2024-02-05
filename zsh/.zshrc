# ------ exports ------
export DOTFILES_LOCATION="${HOME}/personal/dotfiles"
export XDG_CONFIG_HOME="${HOME}/.config"
export EDITOR=code
export BROSWER=firefox

# ------ aliases: directories ------
alias dotfiles="cd $HOME/dotfiles"
alias personal="cd $HOME/personal"
alias work="cd $HOME/work"

# ------ aliases: editor ------
alias v="nvim"
alias vim="nvim"
alias nvim="nvim"

# ------ aliases: git ------
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gch="git checkout"
alias gaa="git add ."
alias gco="git commit -m"
alias gpl="git pull"
alias gps="git push"

# ------ aliases: miscellaneous ------
alias ll='ls -lFG'
alias tp='terraform plan'

# ------ tmux ------
if [[ ! $(tmux list-sessions) ]]; then 
  tmux
fi
