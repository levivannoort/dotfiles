{ pkgs, ... }:

{
  go = pkgs.mkShell {
    packages = with pkgs; [
      go
    ];

    shellHook = ''
      echo "Setting up golang development environment"
    '';
  };
}
