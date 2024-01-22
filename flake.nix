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
          #nu_plugin_bash_env = pkgs.writeShellScriptBin "nu_plugin_bash_env"
          #  (builtins.replaceStrings ["jq"] ["${pkgs.jq}/bin/jq"]
          #    (builtins.readFile ./nu_plugin_bash_env));
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
            #packages.default = nu_plugin_bash_env;
          }
      );
}
