{
  description = "A first go at nix and nix flakes";

  inputs = {
    # Need unstable for flakes.
    # Primary nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # For packages on the edge.
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    # For managing special files in $HOME.
    home-manager.url = "github:nix-community/home-manager";

    # Extras
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      inherit (lib.my) mapModule mapModulesRec mapHosts;

      system = "x86_64-linux";

      # Used to patch nixpkgs.
      # mkPkgs :: nixpkgs fn -> [ overlay ] -> updated nixpkgs fn
      mkPkgs = pkgs: extraOverlays:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = extraOverlays;
        };
      pkgs = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [ ];

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib {
          inherit inputs pkgs;
          lib = self;
        };
      });
    in {
      lib = lib.my;

      overlay = final: prev: {
        unstable = pkgs';
        my = self.packages."${system}";
      };

      # overlays = mapModule import ./overlays;

      # packages."${system}" = mapModule ./packages (p: pkgs.callPackage p { });

      nixosModules = {
        dotfiles = import ./.;
      } // mapModulesRec import ./modules;

      nixosConfigurations = mapHosts ./hosts { };

      # TODO: Write bin/pax.
      defaultApp."${system}" = {
        type = "app";
        program = ./bin/pax;
      };
    };
}
