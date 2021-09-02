{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.network;
in {
  options.modules.network = with types; {
    enable = mkBoolOpt false;
    networkManager = mkOpt types.str "networkmanager";
    vpn = {
      enable = mkBoolOpt false;
      services = mkOpt (listOf str) [ ];
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      user.extraGroups = [ "networkmanager" ];
      networking.networkmanager.enable = true;
      programs.nm-applet.enable = true;
    }

    (mkIf (cfg.vpn.enable) {
      networking.networkmanager.packages =
        map (service: pkgs."networkmanager-${service}") cfg.vpn.services;
    })
  ]);
}
