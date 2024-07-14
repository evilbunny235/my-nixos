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
          {
            nix = {
              registry.nixpkgs.flake = nixpkgs;
              nixPath = ["nixpkgs=flake:nixpkgs"];
            };
          }

          ./hosts/evilpc
        ];
      };

      bogdan-nuc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nix = {
              registry.nixpkgs.flake = nixpkgs;
              nixPath = ["nixpkgs=flake:nixpkgs"];
            };
          }

          ./hosts/bogdan-nuc
        ];
      };
    };

    templates = {
      rust = {
        path = ./templates/rust;
      };
      cpp = {
        path = ./templates/cpp;
      };
    };
  };
}
