# Intel platform options and kernel modules.
{ config, lib, ... }:
{
  boot.kernelModules = [
    "kvm-intel"
    "coretemp"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
