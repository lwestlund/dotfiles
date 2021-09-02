{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.filesystem;
in {
  options.modules.hardware.filesystem = {
    enable = mkBoolOpt false;
    ssd.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.udevil.enable = true;

      environment.systemPackages = with pkgs; [
        # sshfs
        exfat # Windows format.
        ntfs3g # Windows format.
      ];
    }

    (mkIf cfg.ssd.enable { services.fstrim.enable = true; })
  ]);
}
