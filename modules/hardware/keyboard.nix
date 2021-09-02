{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.keyboard;
in {
  options.modules.hardware.keyboard = with types; {
    autoRepeatDelay = mkOpt (nullOr int) null;
    autoRepeatInterval = mkOpt (nullOr int) null;
  };

  config = (mkMerge ([
    (mkIf (cfg.autoRepeatDelay != null) {
      services.xserver.autoRepeatDelay = cfg.autoRepeatDelay;
    })
    (mkIf (cfg.autoRepeatInterval != null) {
      services.xserver.autoRepeatInterval = cfg.autoRepeatInterval;
    })
  ]));
}
