{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = name;
    userEmail = email;

    ignores = [
      ".DS_Store"
    ];
  };
}