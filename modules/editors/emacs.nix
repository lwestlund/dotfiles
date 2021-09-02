{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let
  cfg = config.modules.editors.emacs;
  configDir = config.dotfiles.configDir;
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      enable = mkBoolOpt true;
      fromSSH = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    user.packages = with pkgs; [
      ## Emacs
      binutils
      emacsPgtkGcc # Emacs 28 + pgtk + native-comp

      ## Doom dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls

      ## Optional dependencies
      fd # Faster projectile indexing.
      imagemagick # For image-dired.
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry_emacs) # In-emacs gnupg prompts.
      zstd # For undo-fu-session/unto-tree compression.

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # Project style config.
      # :lang cc
      clang_12
    ];

    env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    modules.shell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    # Remember to get you own doom configuration and place it in ~/.config/doom.
    # I keep mine in a separate repository, but may investigate ways to clone that
    # here using Nix in the future.
  };
}
