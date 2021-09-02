{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.theme;
in {
  config = mkIf (cfg.active == "obsidian") (mkMerge [
    # Desktop-agnositc configuration.
    {
      modules = {
        theme = { wallpaper = mkDefault ./config/wallpaper.jpg; };

        # desktop.browsers = {
        #   firefox.userChrome = concatMapStringSet "\n" readFile [
        #     ./config/firefox/userChrome.css
        #   ];
        # };
      };
    }

    # Desktop (X11) theming.
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [ ];
      fonts = {
        fonts = with pkgs; [
          fira-code
          font-awesome-ttf
          inter
          jetbrains-mono
          (nerdfonts.override { fonts = [ "FiraCode" ]; })
          overpass
        ];
        fontconfig.defaultFonts = {
          sansSerif = [ "Fira Sans" ];
          monospace = [ "Fira Code" ];
        };
      };

      # Compositor
      services.picom = {
        fade = true;
        fadeDelta = 1;
        fadeSteps = [ 1.0e-2 1.2e-2 ];
        shadow = true;
        shadowOffsets = [ (-10) (-10) ];
        shadowOpacity = 0.22;
        # activeOpacity = "1.00";
        # inactiveOpacity = "0.92";
        settings = {
          shadow-radius = 12;
          # blur-background = true;
          # blur-background-frame = true;
          # blur-background-fixed = true;
          blur-kern = "7x7box";
          blur-strength = 320;
        };
      };

      # Login screen theme
      services.xserver.displayManager.lightdm.greeters.mini.extraConfig = ''
        text-color = "#ff79c6"
        password-background-color = "#1E2029"
        window-color = "#181a23"
        border-color = "#181a23"
      '';

      # Other dotfiles
      home.configFile = with config.modules;
        mkMerge [
          (mkIf desktop.bspwm.enable {
            "bspwm/rc.d/polybar".source = ./config/polybar/run.sh;
            "bspwm/rc.d/theme".source = ./config/bspwmrc;
          })
          (mkIf (desktop.bspwm.enable || desktop.i3.enable) {
            "polybar" = {
              source = ./config/polybar;
              recursive = true;
            };
            "dunst/dunstrc".source = ./config/dunst/dunstrc;
          })
          (mkIf desktop.apps.rofi.enable {
            "rofi/theme" = {
              source = ./config/rofi;
              recursive = true;
            };
          })
        ];
    })
  ]);
}
