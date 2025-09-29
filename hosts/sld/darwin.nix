{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  homebrew = {
    enable = true;

    casks = [
      "firefox"
      "tableplus"
      "spotify"
      "discord"
      "figma"
      "whatsapp"
      "obsidian"
      "slack"
      "docker"
      "docker-compose"
      "obs"
    ];

    masApps = {
      "magnet" = 441258766;
      "wireguard" = 1451685025;
    };
  };
}
