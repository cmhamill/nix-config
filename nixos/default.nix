{ lib, ... }:
{
  fonts.enableDefaultPackages = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  nix = {
    channel.enable = false;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      flake-registry = ""; # Disable global registry.
      use-xdg-base-directories = true;
    };
  };

  time.timeZone = lib.mkDefault "America/Los_Angeles";
}
