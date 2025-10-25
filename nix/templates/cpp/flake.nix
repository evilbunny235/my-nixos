{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    project_name = "test";

    nativeBuildInputs = [
      pkgs.clang-tools
      pkgs.clang
      pkgs.cmake
    ];

    buildInputs = [];
  in {
    formatter.x86_64-linux = pkgs.alejandra;

    devShells.${system}.default =
      pkgs.mkShell.override {
        stdenv = pkgs.clangStdenv;
      } {
        inherit nativeBuildInputs buildInputs;

        packages = [
          pkgs.lldb
        ];
      };

    packages.${system}.default = pkgs.stdenv.mkDerivation {
      inherit nativeBuildInputs buildInputs;
      pname = project_name;
      version = "0.1.0";

      src = ./.;

      installPhase = ''
        mkdir -p $out/bin
        cp ${project_name} $out/bin
      '';
    };
  };
}
