{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    masApps = {
      "magnet" = 441258766;
      "wireguard" = 1451685025;
    };
  };
}
