{
  description = "Coua demo";
  inputs = {
    coua.url = "github:DLR-FT/coua";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  outputs = { coua, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          coua.packages.${system}.coua
          coua.packages.${system}.morph-kgc
          coua.packages.${system}.sphinx-sparql

          pkgs.cargo
          pkgs.cargo-nextest
          pkgs.gnumake
          pkgs.jq
          pkgs.rustc
          pkgs.rust-analyzer
          pkgs.rustfmt
          pkgs.sphinx
          pkgs.sqlite
        ];
      };
    };
}
