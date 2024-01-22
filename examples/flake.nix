{
  description = "Make kseq_split available in devShell from its flake.";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = "github:numtide/flake-utils";
    kseq_split = {
      url = "github:AgResearch/kseq_split";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, kseq_split }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          flakePkgs = {
            kseq_split = kseq_split.packages.${system}.default;
          };
        in
          with pkgs;
          {
            devShells.default = mkShell {
              buildInputs = [
                flakePkgs.kseq_split
              ];
            };
          }
      );
}
