{
  description = "My hello world";
  inputs = {
    coua.url = "git+https://gitlab.dlr.de/ft-ssy-avs/ap/coua.git";
    nixpkgs.follows = "coua/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { coua, flake-utils, nixpkgs, ... }: flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          coua.overlays.default
          (final: prev: {
            sphinx = prev.sphinx.overrideAttrs {
              dependencies = (prev.sphinx.dependencies ++ [prev.coua]);
            };
          })
        ];
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.coua
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
    }
  );
}
