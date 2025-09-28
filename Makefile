HOSTNAME ?= $(shell hostname)
FLAKE ?= .#$(HOSTNAME)
EXPERIMENTAL ?= --extra-experimental-features "nix-command flakes"

.PHONY: help install-nix install-nix-darwin darwin-rebuild

help:
	@echo "Available targets:"
	@echo "  install-nix         - Install the nix"
	@echo "  install-nix-darwin  - Install nix-darwin"
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
