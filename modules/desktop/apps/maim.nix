{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.maim;
in {
  options.modules.desktop.apps.maim = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ maim ]; };
}
