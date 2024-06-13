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

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "gw";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    model = "pc104";
    options = "lv3:ralt_alt,ctrl:nocaps,compose:prsc";
  };

  system.stateVersion = "24.05";
}
