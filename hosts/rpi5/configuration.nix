{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "rpi5";

  services.openssh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
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
