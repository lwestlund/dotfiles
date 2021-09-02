{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  boot = {
    initrd.availableKernelModules = [
      "ahci" # SATA drives.
      # nvme # NVMe drives.
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
    # TODO: Nvidia?
    nvidia = { enable = true; };
    sensors = { enable = true; };
  };

  ## CPU
  # TODO: Set correct core count.
  nix.maxJobs = lib.mkDefault 4;
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

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
  # TODO: Probably want swap.
  swapDevices = [ ];

  # TODO: Probably want luks.
  # boot.initrd.luks.devices.home = {
  #   device = "/dev/sdxn";
  #   preLVM = true;
  #   allowDiscards = true;
  # };
}
