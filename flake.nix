{
  description = ".dotfiles github.com/levivannoort";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-darwin, ... }: {
    darwinConfigurations."sld" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.levi = import ./home-manager.nix;
        }
      ];
    };
  };
}
