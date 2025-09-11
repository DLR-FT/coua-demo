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
      python = pkgs.python3.override {
        packageOverrides = final: prev: {
          malkoha = coua.packages.${system}.malkoha;
          sphinx-sparql = coua.packages.${system}.sphinx-sparql;
          morph-kgc = coua.packages.${system}.morph-kgc;
        };
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          coua.packages.${system}.coua
          (python.withPackages (ps: [
            ps.malkoha
            ps.morph-kgc
            ps.pytest
            ps.pytest-cov
            ps.sphinx-sparql
          ]))
          pkgs.gnumake
          pkgs.jq
          pkgs.sphinx
          pkgs.sqlite
        ];
      };
    };
}
