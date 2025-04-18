# Enable Intel CPU.
{ config, lib, ... }:
let
  cfg = config.build.hardware.cpu;
in
{
  options.build.hardware.cpu = {
    intel = lib.mkOption {
      description = "Enable Intel CPU kernel modules";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.intel {
    boot.kernelModules = [
      "kvm-intel"
      "coretemp"
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
