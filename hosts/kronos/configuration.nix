{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/mmcblk1";
  boot.loader.grub.useOSProber = true;

  boot.initrd.luks.devices."luks-1669d8e7-a68f-4751-aefd-30ca44663918".device = "/dev/disk/by-uuid/1669d8e7-a68f-4751-aefd-30ca44663918";
  boot.initrd.secrets = {
    "/boot/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-bdd3bbd9-bff0-4c64-b3e4-4a0dbf89654e".keyFile = "/boot/crypto_keyfile.bin";
  boot.initrd.luks.devices."luks-1669d8e7-a68f-4751-aefd-30ca44663918".keyFile = "/boot/crypto_keyfile.bin";
  networking.hostName = "kronos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
