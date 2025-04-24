# Configuration for host module "gpu-amd".
{ config, lib, ... }:
let
  cfg = config.build.host.gpu;
in
{
  imports = [
    (lib.mkAliasOptionModuleMD [ "build" "host" "gpu" "opencl" ] [ "hardware" "amdgpu" "opencl" ])
    # Otherwise boot log is output very low res (800x600?):
    (lib.mkAliasOptionModuleMD [ "build" "host" "gpu" "initrd" ] [ "hardware" "amdgpu" "initrd" ])
  ];

  options = {
    build.host.gpu = {
      maker = lib.mkOption { type = lib.types.nullOr (lib.types.enum [ "amd" ]); };
    };
  };

  config = lib.mkIf (cfg.maker == "amd") {
    hardware.amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
