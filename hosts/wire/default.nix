{ ... }:

{
  imports = [ ../home.nix ./hardware_configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        discord.enable = true;
        flatpak.enable = true;
        rofi.enable = true;
        signal.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      games = {
        steam.enable = true;
        lutris.enable = true;
      };
      media = {
        documents = {
          enable = true;
          pdf.enable = true;
        };
        mpv.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "alacritty";
        alacritty.enable = true;
      };
      vm = { };
    };
    dev = {
      cc.enable = true;
      nix.enable = true;
      python = {
        enable = true;
        packages = [ "numpy" ];
      };
      shell.enable = true;
    };
    editors = {
      default = "nvim";
      emacs = {
        enable = true;
        doom.enable = true;
      };
      vim.enable = true;
    };
    network = {
      enable = true;
      vpn = {
        enable = true;
        services = [ "openvpn" ];
      };
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      htop.enable = true;
      zsh.enable = true;
    };
    theme.active = "obsidian";
  };

  programs.ssh.startAgent = true;
}
