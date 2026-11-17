{ pkgs, lib, ... }:
{
  imports = [
    ./hardware/rpi5.nix
    ../common.nix
  ];
  networking.hostName = "rpi5";
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;

  system.stateVersion = "26.11";
}
