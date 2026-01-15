# dotfiles

Used for storing configuration files on the workstation. These directories/files are written back to git to have settings persist over a re-install of the workstation.

## requirements

First we install `brew`, and via brew we install `git` and `stow`. These two tool will be used to first fetch the configuration via git and after that symlink the configuration via stow.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && brew install git stow
```

```shell
git clone https://github.com/levivannoort/dotfiles ~/.dotfiles
```

## installation

```shell
brew bundle --file=brew/.config/brew/Brewfile
```

```shell
stow --dir /Users/levi/.dotfiles --target /Users/levi/ brew git k9s osx tmux zsh fzf ghostty
```
