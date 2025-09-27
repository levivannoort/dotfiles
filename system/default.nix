{ pkgs, ... }:

{
  system = {
    defaults = {  
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
      };

      dock = {
        autohide = true;
        show-recents = false;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        DisableAllAnimations = true;
        ShowPathbar = true;
        AppleShowAllFiles = true;
      };
    };
  };
}