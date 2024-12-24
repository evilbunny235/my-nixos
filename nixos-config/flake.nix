{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    tuxedo-nixos = {
      url = "github:blitz/tuxedo-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    tuxedo-nixos,
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      evilpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nix = {
              registry.nixpkgs.flake = nixpkgs;
              nixPath = ["nixpkgs=flake:nixpkgs"];
            };
          }

          ./hosts/evilpc
        ];
      };

      bog-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nix = {
              registry.nixpkgs.flake = nixpkgs;
              nixPath = ["nixpkgs=flake:nixpkgs"];
            };
          }

          tuxedo-nixos.nixosModules.default
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
