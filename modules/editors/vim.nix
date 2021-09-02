# TODO: Harmonize vim config with emacs config.
{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
in {
  options.modules.editors.vim = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      editorconfig-core-c
      # Unstable for latest version.
      unstable.neovim
    ];

    environment.shellAliases = {
      vim = "nvim";
      v = "nvim";
    };
  };
}
