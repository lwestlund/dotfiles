{ inputs, config, lib, pkgs, ... }:

with lib;
with lib.my; {
  imports =
    # home-manager deploys files to $HOME!
    [ inputs.home-manager.nixosModules.home-manager ]
    ++ (mapModulesRec' import (toString ./modules));

  environment.variables.DOTFILES = config.dotfiles.dir;
  environment.variables.DOTFILES_BIN = config.dotfiles.binDir;

  # Configure nix and nixpkgs.
  # See https://nixos.org/manual/nixos/stable/options.html.
  nix = let
    # Filter out "self", keep all other attrs in flake inputs.
    filteredInputs = filterAttrs (name: _: name != "self") inputs;
    nixPathInputs =
      mapAttrsToList (name: value: "${name}=${value}") filteredInputs;
    # To be able to do 'registryInputs.foo.flake -> value'.
    registryInputs = mapAttrs (_: value: { flake = value; }) filteredInputs;
  in {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    nixPath = nixPathInputs ++ [
      # Path to ./overlays
      "nixpkgs-overlays=${config.dotfiles.dir}/overlays"
      # Path to .
      "dotfiles=${config.dotfiles.dir}"
    ];

    # A system-wide flake registry.
    registry = registryInputs // { dotfiles.flake = inputs.self; };

    autoOptimiseStore = true;
  };

  # And now for some defaults for all configs.

  # Requires a disk with label "nixos".
  # Required by 'nix flake check' for hosts without a hardware-configuration.nix
  # or other fileSystems config.
  fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

  boot = {
    loader = {
      systemd-boot.enable = mkDefault true;
      systemd-boot.configurationLimit = 10;
    };
  };

  # A minimal system.
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    coreutils
    git
    unzip
  ];
}
