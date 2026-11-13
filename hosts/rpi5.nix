{ pkgs, lib, ... }:
{
  imports = [ ./hardware/rpi5.nix ];

  networking.hostName = "rpi5";
  services.openssh.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;
  users.users."jo" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
  system.stateVersion = "26.11";
}
