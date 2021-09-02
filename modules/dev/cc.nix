{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.cc;
in {
  options.modules.dev.cc = with types; {
    enable = mkBoolOpt false;
    clang = { version = mkOpt str "12"; };
    gcc = { version = mkOpt str "11"; };
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      pkgs."clang_${cfg.clang.version}"
      clang-tools
      pkgs."gcc${cfg.gcc.version}"
      gdb
      cmake
      cmake-format
      meson
      ninja
    ];
  };
}
