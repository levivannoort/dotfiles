{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Levi van Noort";
    userEmail = "73097785+levivannoort@users.noreply.github.com";

    ignores = []
  }
}