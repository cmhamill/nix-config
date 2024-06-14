{ config, lib, pkgs, ... }:

{
  imports = [
    ./disko.nix
  ];

  boot = {
    extraModulePackages = [ ];

    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];
    };

    kernelModules = [ ];

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = !config.boot.lanzaboote.enable;
    };

  };

  console.useXkbConfig = true;

  environment.systemPackages = lib.mkIf config.boot.lanzaboote.enable [
    pkgs.sbctl
  ];


  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "gw";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  services = {
    fwupd.enable = true;

    xserver.xkb = {
      layout = "us";
      model = "pc104";
      options = "lv3:ralt_alt,ctrl:nocaps,compose:prsc";
    };
  };

  system.stateVersion = "24.05";
}
