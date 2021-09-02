{ ... }:

{
  imports = [ ../home.nix ./hardware_configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        discord.enable = false;
        rofi.enable = true;
        signal.enable = false;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      games = {
        steam.enable = false;
        lutris.enable = false;
      };
      media = {
        documents = {
          enable = true;
          pdf.enable = true;
        };
        mpv.enable = false;
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
      emacs = { enable = true; };
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
      git.enable = true;
      htop.enable = true;
      zsh.enable = true;
    };
    theme.active = "obsidian";
  };

  programs.ssh.startAgent = true;
}
