{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.games.steam;
in {
  options.modules.desktop.games.steam = with types; {
    enable = mkBoolOpt false;
    libDir = mkOpt str "$XDG_DATA_HOME/steamlib";
  };

  config = mkIf cfg.enable {
    # This is yanked from programs/steam.nix.
    hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = config.hardware.pulseaudio.enable;
    hardware.steam-hardware.enable = true;

    # This is because I want to keep .steam* out of my $HOME.
    user.packages = with pkgs; [
      # Mock $HOME for Steam.
      (writeScriptBin "steam" ''
        #!${stdenv.shell}
        HOME="${cfg.libDir}" exec ${steam}/bin/steam "$@"
      '')
      # Add a desktop item so that we can start it easily.
      (makeDesktopItem {
        name = "steam";
        desktopName = "Steam";
        icon = "steam";
        exec = "steam";
        terminal = "false";
        mimeType = "x-scheme-handler/steam";
        categories = "Network;FileTransfer;Game";
      })
    ];
    system.userActivationScripts.setupSteamDir = ''mkdir -p "${cfg.libDir}"'';

    # Increase the number of file descriptors that can be created. Some Proton games
    # apparently require a lot of them.
    systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  };
}
