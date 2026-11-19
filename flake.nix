{
  description = "NixOS configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  nixConfig = {
    extra-substituters = [ "https://nixos-raspberrypi.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      nixos-raspberrypi,
      ...
    }@inputs:
    let
      rpi5Hardware =
        { nixos-raspberrypi, ... }:
        {
          imports = with nixos-raspberrypi.nixosModules; [
            raspberry-pi-5.base
            raspberry-pi-5.page-size-16k
          ];
        };
    in
    {
      nixosConfigurations = {
        # Day-to-day config, deployed with nixos-rebuild
        rpi5 = nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            rpi5Hardware
            ./hosts/rpi5.nix
          ];
        };

        # Flashable SD image: same config plus the sd-image module
        rpi5-image = nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
            rpi5Hardware
            ./hosts/rpi5-image.nix # image-only tweaks (can be nearly empty)
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/vm.nix ];
        };

        t480 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
            ./hosts/t480.nix
          ];
        };
      };
    };
}
