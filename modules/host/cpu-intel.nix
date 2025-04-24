# Configuration for host module "cpu-intel".
{ config, lib, ... }:
let
  cfg = config.build.host.cpu;

  defaultModules = [
    "kvm-intel"
    "coretemp"
  ];
in
{
  options = {
    build.host.cpu = {
      maker = lib.mkOption { type = lib.types.nullOr (lib.types.enum [ "intel" ]); };
    };
  };

  config = lib.mkIf (cfg.maker == "intel") {
    boot.kernelModules = (if cfg.modules != null then cfg.modules else defaultModules);
    nixpkgs.hostPlatform = cfg.platform;
    hardware.cpu.intel.updateMicrocode = cfg.updateMicrocode;
  };
}
