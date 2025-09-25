{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    keyMode = "vi";
    newSession = true;
    historyLimit = 10000;
    baseIndex = 1;
    statusInterval = 1;

    extraConfig = ''
      set -g renumber-windows on
      set -g window-status-format '[#I: #W #F]'
      set -g window-status-current-format '[#I: #W #F]'

      set -g status-style "fg=#665c54"
      set -g status-left-style "fg=#928374"
      set -g status-bg default
      set -g status-position top
      set -g status-justify centre
      set -g status-left ""
      set -g status-right ""
    '';
  }
};
