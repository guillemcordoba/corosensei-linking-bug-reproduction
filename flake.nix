{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    p2p-shipyard.url = "github:darksoil-studio/p2p-shipyard/next";
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
