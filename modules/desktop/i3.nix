{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.desktop.i3;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.i3 = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    modules.theme.onReload.i3 = ''
      ${pkgs.i3-gaps}/bin/i3-msg restart
    '';

    environment.systemPackages = with pkgs; [
      lightdm
      lightlocker
      dunst
      libnotify
      (polybar.override {
        pulseSupport = true;
        nlSupport = true;
        i3GapsSupport = true;
      })
    ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        enable = true;
        displayManager = { defaultSession = "none+i3"; };
        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          configFile = "${configDir}/i3/config";
          extraPackages = [ ];
        };
      };
    };

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };

    # link recursively so other modules can link files in their folders
    home.configFile."i3" = {
      source = "${configDir}/i3";
      recursive = true;
    };
  };
}
