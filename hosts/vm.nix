{ pkgs, ... }:

{
  imports = [
    ./hardware/vm.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "nix";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  programs.sway.enable = true;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    ghostty
    git
    neovim
  ];

  services.printing.enable = true;
  users.users."jo" = {
    isNormalUser = true;
    description = "jo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  nixpkgs.config.allowUnfree = true;
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
