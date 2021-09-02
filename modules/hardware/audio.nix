{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkBoolOpt false;
    pasystray.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      sound.enable = true;
      sound.mediaKeys.enable = true;
      hardware.pulseaudio.enable = true;

      user.extraGroups = [ "audio" ];
    }

    (mkIf cfg.pasystray.enable { user.packages = [ pkgs.pasystray ]; })
  ]);
}
