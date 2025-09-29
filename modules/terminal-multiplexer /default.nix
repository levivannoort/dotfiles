{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    shortcurt = "b";
    keyMode = "vi";
    newSession = true;
    historyLimit = 10000;
    clock24 = true;
    baseIndex = 1;

    extraConfig = ''
      set -g default-terminal "alacritty"
      set -g mouse on
      set -g terminal-overrides ',*256color*:smcup@:rmcup@'
      set -g status 'on'

      set -g renumber-windows on
      set -g set-clipboard on

      set -g window-status-format '[#I: #W #F]'
      set -g window-status-current-format '[#I: #W #F]'

      set -g status-interval 1
      set -g status-style "fg=#665c54"
      set -g status-left-style "fg=#928374"
      set -g status-bg default
      set -g status-position top
      set -g status-justify centre
      set -g status-left ""
      set -g status-right ""
    '';
  };
}
