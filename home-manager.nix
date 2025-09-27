{ config, pkgs, username, ... }:

let
  name      = "Levi van Noort";
  username  = "levi";
  email     = "73097785+levivannoort@users.noreply.github.com";
in {
  imports = [
    code-editor
    git
    shell
    system
    terminal-emulator
    terminal-multiplexer
  ];

  home.packages = [
    pkgs.jq
    pkgs.yq
    pkgs.htop
    pkgs.vagrant
    pkgs.packer
    pkgs.terraform
    pkgs.opentofu
    pkgs.tree
    pkgs.bat
    pkgs.fzf
    pkgs.grep
    pkgs.watch
    pkgs.sqlite
    pkgs.kustomize
    pkgs.helm
    pkgs.argocd
    pkgs.kubent
    pkgs.kubectx
    pkgs.curl
    pkgs.redis
    pkgs.k9s
    pkgs.k6
    pkgs.awscli2
    pkgs.granted
    pkgs.slides
    pkgs.goose

    pkgs.go
    pkgs.lua
    pkgs.cue
  ];

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    masApps = {
      "magnet" = 441258766;
      "wireguard" = 1451685025;
    };
  };

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
