{ lib, pkgs, ... }:
{
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_6_17;

  # ZFS 2.3.4 (latest stable) supports kernels up to 6.16, which NixOS
  # no longer supports. Enable ZFS 2.4.0 (currently rc3) so the kernel
  # can be upgraded to 6.17, making lapnix updateable once again.
  boot.zfs.package = pkgs.zfs_unstable;

  boot.loader = {
    timeout = 0;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
    };
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "lapnix";
    useDHCP = lib.mkDefault true;
  };
}
