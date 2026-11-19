{
  description = "NixOs / Nix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        rpi5 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-5
            ./hosts/rpi5.nix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./hosts/vm.nix
          ];
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
