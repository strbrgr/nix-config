{ pkgs, ... }:

{
  users.users.jo = {
    isNormalUser = true;
    description = "jo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCJyJ4HghnqXpEdSR6Ex9EhxOmGbWLMUAkU6y2c/Oe8"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    vim
  ];
}
