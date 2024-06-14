{ config, lib, ... }:
{
  users.users.cmh = {
    description = "C. Morgan Hamill";
    isNormalUser = true;

    extraGroups = [
      (lib.mkIf config.networking.networkmanager.enable "networkmanager")
      (lib.mkIf config.security.sudo.enable "wheel")
    ];
  };
}
