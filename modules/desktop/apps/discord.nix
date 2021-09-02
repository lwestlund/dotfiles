{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.apps.discord;
  discordAppId = "com.discordapp.Discord";
in {
  options.modules.desktop.apps.discord = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = config.services.flatpak.enable;
      message = "Flatpak required to fetch Discord";
    }];

    modules.desktop.apps.flatpak.apps = { "discord" = discordAppId; };
  };
}
