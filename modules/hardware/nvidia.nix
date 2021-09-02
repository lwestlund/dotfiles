{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.nvidia;
in {
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
    switchable = {
      enable = mkBoolOpt false;
      intelBusId = mkOpt types.str "";
      nvidiaBusId = mkOpt types.str "";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.switchable.enable {
      hardware.nvidia.prime = {
        offload.enable = true;
        intelBusId = cfg.switchable.intelBusId;
        nvidiaBusId = cfg.switchable.nvidiaBusId;
      };
    })

    {
      services.xserver.videoDrivers = [ "nvidia" ];

      environment.systemPackages = with pkgs;
        [
          (writeScriptBin "nvidia-settings" ''
            #!${stdenv.shell}
            mkdir -p "$XDG_CONFIG_HOME/nvidia"
            exec ${config.boot.kernelPackages.nvidia_x11.settings}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
          '')
        ];
    }
  ]);
}
