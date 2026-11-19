{ lib, ... }:
{
  # Root: must match sdImage.rootPartitionUUID in rpi5-image.nix
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  # Firmware/boot partition: needed on the live system so rebuilds
  # can update kernel + firmware. Label should match what the image creates.
  fileSystems."/boot/firmware" = lib.mkDefault {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = [
      "noatime"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=1min"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
