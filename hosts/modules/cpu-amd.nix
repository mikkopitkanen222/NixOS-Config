# Configuration for host module "cpu-amd".
{ config, lib, ... }:
let
  cfg = config.build.host.cpu;
in
{
  options.build.host.cpu = {
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
