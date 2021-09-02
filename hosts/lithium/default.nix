{ ... }:

{
  imports = [ ../home.nix ./hardware_configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      i3.enable = true;
      apps = {
        maim.enable = true;
        rofi.enable = true;
        signal.enable = true;
      };
      browsers = {
        default = "firefox";
        firefox.enable = true;
      };
      games = { steam.enable = true; };
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
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    dev = {
      cc.enable = true;
      python.enable = true;
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
      zsh.enable = true;
    };
  };

  programs.ssh.startAgent = true;
}
