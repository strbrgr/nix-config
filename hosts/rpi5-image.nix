{
  config,
  lib,
  nixos-raspberrypi,
  ...
}:
{
  imports = [
    ./rpi5.nix
    nixos-raspberrypi.nixosModules.sd-image
  ];

  # Match the normal rpi5 target so subsequent rebuilds keep the same root device.
  sdImage.rootPartitionUUID = "44444444-4444-4444-8888-888888888888";
  fileSystems."/".device = lib.mkForce "/dev/disk/by-uuid/${config.sdImage.rootPartitionUUID}";
}
