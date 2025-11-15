{ pkgs, ... }: {
  system = {
    primaryUser = username;

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

        persistent-apps = [
          "/Applications/Firefox.app"
          "/Applications/Discord.app"
          "/Applications/Obsidian.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Tableplus.app"
          "/Applications/Spotify.app"
        ];
      };

      finder = {
        DisableAllAnimations = true;
        ShowPathbar = true;
        AppleShowAllFiles = true;
      };
    };
  };
}