{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        decorations = "buttonless";
        dynamic_padding = true;
        padding = {
          x = 10;
          y = 10;
        };
      };

      fonts = {
        size = 12.5;

        normal = {
          family = "SFMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "SFMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "SFMono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "SFMono Nerd Font";
          style = "Bold Italic";
        };
      };

      general = {
        live_config_reload = true;
      };
    };
  };
}