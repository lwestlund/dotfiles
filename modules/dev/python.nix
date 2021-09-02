{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.python;
in {
  options.modules.dev.python = with types; {
    enable = mkBoolOpt false;
    version = mkOpt str "39";
    packages = mkOpt (listOf str) [ ];
  };

  config = mkIf cfg.enable (mkMerge [
    {
      user.packages = [
        pkgs."python${cfg.version}"
        pkgs."python${cfg.version}Packages".pip
        pkgs."python${cfg.version}Packages".black
      ];
    }

    (mkIf (cfg.packages != [ ]) {
      user.packages =
        map (pkg: pkgs."python${cfg.version}Packages"."${pkg}") cfg.packages;
    })

    {
      env.PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
      env.PIP_LOG_FILE = "$XDG_DATA_HOME/pip/log";
      env.PYTHONSTARTUP = "$XDG_CONFIG_HOME/python/pythonrc";
    }
  ]);
}
