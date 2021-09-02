{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.htop;
in {
  options.modules.shell.htop = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = [ pkgs.htop ]; };
}
