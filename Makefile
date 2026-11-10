# Bootstrap and manage this dotfiles checkout.
# Every path is derived from this file's location, so the repo works from any
# clone location and any user account.

SHELL := /usr/bin/env bash
DOTFILES := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGET ?= $(HOME)
BREWFILE := $(DOTFILES)/brew/.config/brew/Brewfile

PACKAGES := brew claude fzf ghostty git k9s kube tmux vim zsh

# --no-folding is deliberate and applies to every package.
#
# By default stow "folds": when a target directory does not exist yet it
# creates one symlink for the whole directory. That is how ~/.claude became a
# symlink into this repo, which put Claude's runtime state (transcripts,
# history.jsonl, caches, .claude.json backups) inside the working tree. The
# same trap applies to shared directories like ~/.local and ~/.config, where a
# fold hands the entire tree to whichever package got there first.
#
# --no-folding creates real directories containing per-file symlinks instead,
# so a package only ever owns the exact files it ships.
STOW := stow --dir "$(DOTFILES)" --target "$(TARGET)" --no-folding

.DEFAULT_GOAL := help

.PHONY: help
help: ## show this help
	@grep -hE '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: brew stow ## install packages and symlink every config

.PHONY: brew
brew: ## install everything in the Brewfile
	brew bundle --file="$(BREWFILE)"

.PHONY: stow
stow: ## symlink all packages into $$HOME
	$(STOW) --restow $(PACKAGES)

.PHONY: unstow
unstow: ## remove all symlinks from $$HOME
	$(STOW) --delete $(PACKAGES)

.PHONY: restow
restow: unstow stow ## unstow then stow again (picks up renamed/removed files)

.PHONY: macos
macos: ## apply macOS system defaults
	"$(DOTFILES)/scripts/macos-defaults.sh"

.PHONY: migrate-claude
migrate-claude: ## move Claude runtime state out of the repo (run with no session active)
	"$(DOTFILES)/scripts/migrate-claude-state.sh"

.PHONY: check
check: ## dry-run stow, report conflicts, touch nothing
	$(STOW) --no --verbose=1 --restow $(PACKAGES) 2>&1 | grep -v '^BUG' || true

.PHONY: lint
lint: lint-shell lint-yaml ## run every linter

.PHONY: lint-shell
lint-shell: ## syntax-check shell sources
	zsh -n zsh/.zshrc
	zsh -n fzf/.fzf.zsh
	zsh -n zsh/.local/bin/do-fetch-kubernetes-context
	bash -n scripts/macos-defaults.sh
	bash -n scripts/migrate-claude-state.sh
	bash -n scripts/check-no-claude-state.sh

.PHONY: lint-yaml
lint-yaml: ## lint yaml configs
	yamllint -c .yamllint.yaml k9s/ kube/

.PHONY: lint-vim
lint-vim: ## verify .vimrc sources without errors
	vim -es -Nu NONE \
		-c 'let v:errmsg="" | source vim/.vimrc | if v:errmsg != "" | cq | endif' \
		-c 'qa!' </dev/null
