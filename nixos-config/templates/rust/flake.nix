{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [rust-overlay.overlays.default];
    };
    rust_toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
    docker_image_tag = "latest";
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        rust_toolchain
        pkgs.lldb
        pkgs.rust-analyzer-unwrapped
      ];

      RUST_SRC_PATH = "${rust_toolchain}/lib/rustlib/src/rust/library";
      RUST_BACKTRACE = "1";
    };

    packages.${system} = rec {
      # FIXME fix all AAAA
      AAAA = let
        projectPath = ./AAAA;
        manifest = (pkgs.lib.importTOML (projectPath + /Cargo.toml)).package;
      in
        pkgs.rustPlatform.buildRustPackage {
          pname = manifest.name;
          version = manifest.version;
          src = ./AAAA;
          # sourceRoot = "./AAAA";
          cargoLock.lockFile = projectPath + /Cargo.lock;
        };

      docker_img_sender = pkgs.dockerTools.buildLayeredImage {
        inherit docker_image_tag;
        name = AAAA.name;
        config = {
          Cmd = ["${AAAA}/bin/AAAA"];
        };
      };
    };
  };
}
