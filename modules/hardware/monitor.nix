{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.monitor;
in {
  options.modules.hardware.monitor = with types; {
    monitors = mkOpt' (listOf attrs) [ ] "List of monitor configurations";
  };

  config =
    mkIf (cfg.monitors != [ ]) { services.xserver.xrandrHeads = cfg.monitors; };
}
