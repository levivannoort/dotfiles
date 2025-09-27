{ config, pkgs, username, ... }:

let
  name      = "Levi van Noort";
  username  = "levi";
  email     = "73097785+levivannoort@users.noreply.github.com";
in {
  stateVersion = "25.05";

  imports = [
    code-editor
    git
    shell
    ssh
    system
    terminal-emulator
    terminal-multiplexer
    virtualisation
  ];

  environment.systemPackages = with pkgs; [
    jq
    yq
    htop
    vagrant
    packer
    terraform
    opentofu
    tree
    bat
    fzf
    grep
    watch
    sqlite
    kustomize
    helm
    argocd
    kubent
    kubectx
    curl
    redis
    k9s
    k6
    awscli2
    granted
    slides
    goose
    mtr
    gh
    iperf3
    kubectl
    qemu
    libvirt

    go
    lua
    cue
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
