{ pkgs, lib, ... }:
{
  imports = [
    ./hardware/rpi5.nix
    ../common.nix
  ];

  networking.hostName = "rpi5";
  system.stateVersion = "26.11";

  hardware.enableRedistributableFirmware = true;
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
    suspend-then-hibernate.enable = false;
  };

  networking.networkmanager = {
    enable = true;
  };
  boot.extraModprobeConfig = "options cfg80211 ieee80211_regdom=US";
  services = {
    logind.settings.Login.IdleAction = "ignore";

    avahi = {
      enable = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "rpi5-samba";
          "netbios name" = "rpi5";
          "security" = "user";
          "hosts allow" = "192.168.4.0/22 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";

          "vfs objects" = "fruit streams_xattr";
          "fruit:metadata" = "stream";
          "fruit:model" = "MacSamba";
          "fruit:posix_rename" = "yes";
          "fruit:veto_appledouble" = "no";
          "fruit:nfs_aces" = "no";
          "fruit:wipe_intentionally_left_blank_rfork" = "yes";
          "fruit:delete_empty_adfiles" = "yes";
        };

        "1221_B" = {
          "path" = "/srv/1221_B";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "jo";
          "force group" = "users";
        };

        "1221_WC" = {
          "path" = "/srv/1221_WC";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "jo";
          "force group" = "users";
        };
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [
    hfsprogs
  ];

  fileSystems."/srv/1221_B" = {
    device = "/dev/disk/by-uuid/c0eb530e-5848-304d-b101-966ed153e367";
    fsType = "hfsplus";
    options = [
      "force"
      "rw"
      "uid=1000"
      "gid=100"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=0"
      "x-systemd.device-timeout=30s"
    ];
  };

  fileSystems."/srv/1221_WC" = {
    device = "/dev/disk/by-uuid/2d517c58-837c-34e1-b408-654f4f911175";
    fsType = "hfsplus";
    options = [
      "force"
      "rw"
      "uid=1000"
      "gid=100"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=0"
      "x-systemd.device-timeout=30s"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /srv/1221_B 0755 jo users -"
    "d /srv/1221_WC 0755 jo users -"
  ];
}
