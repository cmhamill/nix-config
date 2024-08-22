{ config, lib, pkgs, ... }:
{
  users.users.cmh = {
    description = "C. Morgan Hamill";
    isNormalUser = true;

    extraGroups = [
      (lib.mkIf config.networking.networkmanager.enable "networkmanager")
      (lib.mkIf config.security.sudo.enable "wheel")
    ];
  };
  home-manager.users.cmh = {
    home = {
      packages = with pkgs; [
        discord
      ];

      stateVersion = config.system.stateVersion;
    };

    programs = {
      firefox = {
        enable = true;
      };

      foot = {
        enable = true;
      };

      git = {
        enable = true;
      };

      neovim = {
        enable = true;
      };
    };

    nixpkgs.config.allowUnfree = true;

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
      };
    };
  };
}
