{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.signal;
  signalAppId = "org.signal.Signal";
in {
  options.modules.desktop.apps.signal = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.flatpak.enable;
      message = "Flatpak required to fetch Signal";
    }];

    modules.desktop.apps.flatpak.apps = { "signal" = signalAppId; };
  };
}
