{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ghostty,
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      evilpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit ghostty;
        };
        modules = [
          ./hosts/evilpc
        ];
      };

      bog-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit ghostty;
        };
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
