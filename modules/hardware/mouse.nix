{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.mouse;
in {
  options.modules.hardware.mouse = with types; {
    acceleration = mkBoolOpt false;
    speed =
      mkOpt' str "0.0" "A number in the range [-1, 1] as a float in a string.";
  };

  config = {
    services.xserver.libinput = {
      enable = true;
      mouse = {
        accelProfile = if cfg.acceleration then "adaptive" else "flat";
        accelSpeed = cfg.speed;
      };
    };
  };
}
