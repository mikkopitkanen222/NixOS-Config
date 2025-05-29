# Configuration for host "lapnix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.11";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

  boot.loader = {
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
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
