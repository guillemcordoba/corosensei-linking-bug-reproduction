{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    rust-overlay.url = "github:oxalica/rust-overlay";
    crane.url = "github:ipetkov/crane";
    p2p-shipyard.url = "github:darksoil-studio/p2p-shipyard";
  };

  outputs = inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      systems =
        [ "aarch64-darwin" "x86_64-linux" "x86_64-darwin" "aarch64-linux" ];

      perSystem = { inputs', self', config, pkgs, system, lib, ... }: {
        devShells.default =
          inputs'.p2p-shipyard.devShells.holochainTauriAndroidDev;
      };
    };
}
