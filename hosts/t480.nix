# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware/t480.nix
    ../common.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "t480";

  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.throttled.enable = lib.mkForce false;
  services.thermald.enable = true;

  environment.systemPackages = with pkgs; [
    foot # Fast, minimal Wayland terminal
    wofi # Lightweight application launcher
    waybar # Status bar
    dunst # Lightweight notification daemon
    wl-clipboard # Wayland copy/paste support
    grim # Screenshot utility
    slurp # Screen region selector
    brightnessctl # Backlight control for ThinkPad function keys
    networkmanagerapplet
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
