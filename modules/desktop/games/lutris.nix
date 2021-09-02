{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.games.lutris;
in {
  options.modules.desktop.games.lutris = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ lutris ]; };
}
