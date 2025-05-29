# Configuration for host "previousnix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.11";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_14;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "previousnix";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
