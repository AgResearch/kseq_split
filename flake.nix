{
  description = "Build environment for kseq_split.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          kseq_split =
            with pkgs;
            stdenv.mkDerivation {
              name = "kseq_split";
              src = self;
              buildPhase = "make";
              installPhase = "mkdir -p $out/bin; install -t $out/bin build/kseq_count build/kseq_split build/kseq_test";
              buildInputs = [ zlib ];
            };
        in
          with pkgs;
          {
            devShells.default = mkShell {
              # tools required to build it
              nativeBuildInputs = [
                # temporary investigation
                gnumake
                gcc
                zlib
              ];
            };
            packages.default = kseq_split;
          }
      );
}
