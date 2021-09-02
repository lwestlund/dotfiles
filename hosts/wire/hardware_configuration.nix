{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  boot = {
    initrd.availableKernelModules = [
      "ahci" # SATA drives.
      "xhci_pci" # USB 3.0.
      "usb_storage" # USB flash drives.
      "usbhid"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    kernelParams = [ ];
  };

  ## Modules
  modules.hardware = {
    audio = {
      enable = true;
      pasystray.enable = true;
    };
    bluetooth.enable = false;
    filesystem = {
      enable = true;
      ssd.enable = true;
    };
    keyboard = {
      autoRepeatDelay = 270;
      autoRepeatInterval = 25;
    };
    mouse = {
      acceleration = false;
      speed = "-0.4";
    };
    # TODO: Open an issue and ask why this line
    # https://github.com/NixOS/nixpkgs/blob/3efbe3863aba9bbb49d1f0163d2665b44c125a01/nixos/modules/services/x11/xserver.nix#L100
    # is placed before the monitor config, making it impossible to configure location of monitors.
    # In the meantime, let's add a screen section directly to xserver below.
    # There is also an issue that the correct refresh rate is not set, unknown reason.
    # monitor.monitors = [
    #   {
    #     output = "DP-4";
    #     monitorConfig = ''
    #       ModeLine "1920x1080_119.98" 285.50 1920 1968 2000 2080 1080 1083 1088 1144 +HSync -VSync
    #       Option "DefaultModes" "false"
    #       Option "PreferredMode" "1920x1080_119.98"
    #     '';
    #   }
    #   {
    #     output = "DVI-I-1";
    #     monitorConfig = ''
    #       ModeLine "1920x1080_119.98" 285.50 1920 1968 2000 2080 1080 1083 1088 1144 +HSync -VSync
    #       Option "DefaultModes" "false"
    #       Option "PreferredMode" "1920x1080_119.98"
    #     '';
    #   }
    # ];
    nvidia = { enable = true; };
    sensors = { enable = true; };
  };

  ## CPU
  nix.maxJobs = lib.mkDefault 4;
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  ## Displays
  # Generated using nvidia-settings.
  services.xserver = {
    monitorSection = ''
      VendorName  "Unknown"
      ModelName   "Ancor Communications Inc VG248"
      HorizSync   30.0 - 160.0
      VertRefresh 50.0 - 150.0
      Option      "DPMS"
    '';
    screenSection = ''
      Option "Stereo" "0"
      Option "nvidiaXineramaInfoOrder" "DFP-6"
      Option "metamodes" "DVI-I-1: 1920x1080_120 +0+0, DP-4: 1920x1080_120 +1920+0"
      Option "SLI" "Off"
      Option "MultiGPU" "Off"
      Option "BaseMosaic" "Off"
    '';
  };

  # Storage
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  swapDevices = [ ];
}
