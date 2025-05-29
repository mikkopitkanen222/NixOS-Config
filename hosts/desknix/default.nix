# Configuration for host "desknix".
{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxKernel.packageAliases.linux_latest;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
  };

  networking = {
    hostName = "desknix";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
