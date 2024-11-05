{

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # lib to build a nix package from a rust crate
    crane = { url = "github:ipetkov/crane"; };

    # Rust toolchain
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [ "armv7l-linux" ];

      perSystem = { inputs', self', config, pkgs, system, lib, ... }: {
        devShells.default = pkgs.mkShell {
          packages = let
            overlays = [ (import inputs.rust-overlay) ];
            pkgs = import inputs.nixpkgs { inherit system overlays; };

            # Define a Rust setup that works for your project. This should be a functional default
            # for a scaffolded project but can be adjusted.
            # Options: https://github.com/oxalica/rust-overlay?tab=readme-ov-file#cheat-sheet-common-usage-of-rust-bin
            rust = (pkgs.rust-bin.stable.latest.minimal.override {
              extensions = [ "clippy" "rustfmt" ];
              targets = [ "armv7-unknown-linux-gnueabihf" ];
            });
          in [ rust ];
        };
      };
    };
}
