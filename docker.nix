{ pkgs ? import <nixpkgs> {} }:
with (import ./default.nix {});

pkgs.dockerTools.buildImage {
  name = "urbit";

  contents = urbit;
}
