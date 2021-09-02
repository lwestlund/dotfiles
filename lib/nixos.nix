{ inputs, lib, pkgs, ... }:

with lib;
with lib.my;
let
  sys = "x86_64-linux";
  mkHost = path:
    attrs@{ system ? sys, ... }:
    nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName =
            mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        (filterAttrs (n: v: !elem n [ "system" ]) attrs)
        ../. # ../default.nix
        (import path)
      ];
    };
in {
  mapHosts = dir:
    attrs@{ system ? system, ... }:
    mapModule (hostPath: mkHost hostPath attrs) dir;
}
