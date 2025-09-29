{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
  
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 100000;
    histFile = "$HOME/.history";
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };
}