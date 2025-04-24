# Configuration for host module "cpu-amd".
{ config, lib, ... }:
let
  cfg = config.build.host.cpu;

  defaultModules = [
    "kvm-amd"
    "k10temp"
  ];
in
{
  options = {
    build.host.cpu = {
      maker = lib.mkOption { type = lib.types.nullOr (lib.types.enum [ "amd" ]); };
    };
  };

  config = lib.mkIf (cfg.maker == "amd") {
    boot.kernelModules = (if cfg.modules != null then cfg.modules else defaultModules);
    nixpkgs.hostPlatform = cfg.platform;
    hardware.cpu.amd.updateMicrocode = cfg.updateMicrocode;
  };
}
