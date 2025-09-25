{ config, pkgs, username, ... }:

{
  imports = [
    code-editor
    git
    terminal
    terminal-multiplexer
    shell
  ];

  home.packages = [
    pkgs.jq
    pkgs.htop
    pkgs.vagrant
    pkgs.packer
    pkgs.opentofu
  ];

  home.username = levi;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}