{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [rust-overlay.overlays.default];
    };
    rust_toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.rust-analyzer-unwrapped
      ];

      packages = [
        rust_toolchain
        pkgs.lldb
      ];

      RUST_SRC_PATH = "${rust_toolchain}/lib/rustlib/src/rust/library";
      RUST_BACKTRACE = "1";
    };
  };
}
