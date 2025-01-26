# Amd platform options and kernel modules.
{ config, lib, ... }:
{
  boot.kernelModules = [
    "kvm-amd"
    "k10temp"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
