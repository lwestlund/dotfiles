{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkBoolOpt false;
    audio.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      hardware.bluetooth.enable = true;
      user.packages = [ pkgs.blueman ];
    }

    (mkIf cfg.audio.enable {
      hardware.pulseaudio = {
        # There are two pulseaudio builds avaiable, and only the full one has bluetooth support.
        package = pkgs.pulseaudioFull;
        # Enable additional codecs.
        extraModules = [ pkgs.pulseaudio-modules-bt ];
      };

      hardware.bluetooth.config = {
        General.Enable = "Source,Sink,Media,Socket";
      };
    })
  ]);
}
