{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      evilpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/hosts/evilpc
        ];
      };

      bog-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/hosts/bog-laptop
        ];
      };
    };

    templates = {
      rust = {
        path = ./nix/templates/rust;
        description = "Rust project template";
      };
      cpp = {
        path = ./nix/templates/cpp;
        description = "C++ project template";
      };
    };
  };
}
