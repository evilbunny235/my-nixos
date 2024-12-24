{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      evilpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/evilpc
        ];
      };

      bog-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
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
