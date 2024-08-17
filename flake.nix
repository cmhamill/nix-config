{
  description = "System configurations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks-nix.follows = "";
      };
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "aarch64-darwin"
      "x86_64-linux"
    ];

    perSystem = { pkgs, ...}: {
      apps = {
        repl = {
          type = "app";
          program = "${pkgs.writeShellScript "flake-repl" ''
            nix repl --expr '{ self = builtins.getFlake (toString ./.); }'
          ''}";
        };
      };
    };

    flake = {
      nixosConfigurations = {
        gw = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            inputs.disko.nixosModules.disko
            inputs.home-manager.nixosModules.home-manager
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen

            ./nixos
            ./hosts/gw
            ./users/cmh
          ];
        };
      };
    };
  };
}
