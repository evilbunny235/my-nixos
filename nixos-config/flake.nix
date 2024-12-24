{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pin_nixpkgs = {
      nix = {
        registry.nixpkgs.flake = nixpkgs;
        nixPath = ["nixpkgs=flake:nixpkgs"];
      };
    };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      evilpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          pin_nixpkgs
          ./hosts/evilpc
        ];
      };

      bog-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          pin_nixpkgs
          ./hosts/bog-laptop
        ];
      };
    };

    templates = {
      rust = {
        path = ./templates/rust;
        description = "Rust project template";
      };
      cpp = {
        path = ./templates/cpp;
        description = "C++ project template";
      };
    };
  };
}
