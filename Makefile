HOSTNAME ?= $(shell hostname)
FLAKE ?= .#$(HOSTNAME)
EXPERIMENTAL ?= --extra-experimental-features "nix-command flakes"

.PHONY: help darwin-rebuild

help:
	@echo "Available targets:"
	@echo "  install-nix         - Install the nix package manager"
	@echo "  darwin-rebuild      - Rebuild the nix-darwin configuration"

install-nix:
	@echo "Installing nix..."
	@sudo curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
	@echo "Nix installation complete..."

install-nix-darwin:
	@echo "Installing nix-darwin..."
	@sudo nix run nix-darwin $(EXPERIMENTAL) -- switch --flake $(FLAKE)
	@echo "Nix-darwin installation complete..."

darwin-rebuild:
	@echo "Rebuilding darwin configuration..."
	@sudo darwin-rebuild switch --flake $(FLAKE)
	@echo "Darwin rebuild complete..."
