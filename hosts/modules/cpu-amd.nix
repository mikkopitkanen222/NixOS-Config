# Enable AMD CPU.
{ config, lib, ... }:
let
  cfg = config.build.hardware.cpu;
in
{
  options.build.hardware.cpu = {
    amd = lib.mkOption {
      description = "Enable AMD CPU kernel modules";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.amd {
    boot.kernelModules = [
      "kvm-amd"
      "k10temp"
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
