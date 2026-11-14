{ pkgs, lib, ... }:
{
  imports = [ ./hardware/rpi5.nix ];

  networking.hostName = "rpi5";
  services.openssh.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;
  users.users."nixos" = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCJyJ4HghnqXpEdSR6Ex9EhxOmGbWLMUAkU6y2c/Oe8 jocsti@web.de"
    ];
  };
  users.users.jo = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCJyJ4HghnqXpEdSR6Ex9EhxOmGbWLMUAkU6y2c/Oe8 jocsti@web.de"
    ];
  };
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
  system.stateVersion = "26.11";
}
