{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.games.emulators;
in {
  options.modules.desktop.games.emulators = {
    psx.enable = mkBoolOpt false; # PlayStation.
    ds.enable = mkBoolOpt false; # Nintento DS.
    gb.enable = mkBoolOpt false; # GameBoy + GameBoy Color.
    gba.enable = mkBoolOpt false; # GameBoy Advance.
    snes.enable = mkBoolOpt false; # Super Nintendo.
  };

  config = {
    user.packages = with pkgs; [
      (mkIf cfg.psx.enable epsxe)
      (mkIf cfg.ds.enable desmume)
      (mkIf (cfg.gb.enable || cfg.gba.enable || cfg.snes.enable) higan)
    ];
  };
}
