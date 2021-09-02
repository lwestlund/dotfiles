{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  boot = {
    initrd.availableKernelModules = [
      "ath9k" # Wireless.
      "r8169" # Ethernet.
      "ahci" # SATA drives.
      "xhci_pci" # PCI devices?
      "rtsx_pci_sdmmc" # SD/MMC card host driver.
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
    kernelParams = [ ];
  };

  ## Modules
  modules.hardware = {
    audio = {
      enable = true;
      pasystray.enable = true;
    };
    bluetooth.enable = true;
    filesystem = {
      enable = true;
      ssd.enable = true;
    };
    nvidia = {
      enable = true;
      switchable = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    touchpad.enable = true;
  };

  ## CPU
  nix.maxJobs = lib.mkDefault 8;
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  ## Power management
  environment.systemPackages = [ pkgs.acpi ];
  powerManagement.powertop.enable = true;

  ## Monitor backlight control
  programs.light.enable = true;
  user.extraGroups = [ "video" ];

  networking.wireless.interfaces = [ "wlp8s0" ];

  # Storage
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
  swapDevices = [{ label = "swap"; }];
}
