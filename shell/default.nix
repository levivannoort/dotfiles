{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
  
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histSize = 100000;
    histFile = "$HOME/.history";
    setOptions = [
      "hist_ignore_dups",
      "share_history"
    ];
  }

  programs.fzf.enableZshIntegration = true;
}