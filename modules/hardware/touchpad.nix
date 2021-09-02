{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.touchpad;
in {
  options.modules.hardware.touchpad = { enable = mkBoolOpt false; };
  config =
    mkIf cfg.enable { user.packages = with pkgs; [ libinput-gestures ]; };
}
