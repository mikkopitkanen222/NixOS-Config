{ config, lib, ... }:
let
  cfg = config.mp222.amdgpu;

  discrete = config.mp222.host.amdGpuName != null;
in
{
  options.mp222.amdgpu = {
    enable = lib.mkEnableOption "AMD GPU support";
  };

  config = lib.mkIf cfg.enable {
    hardware.amdgpu = {
      # Fix archaic image resolution (640x480) during boot:
      initrd.enable = true;
      opencl.enable = lib.mkDefault discrete;
      overdrive.enable = lib.mkDefault discrete;
    };
    services.lact.enable = lib.mkDefault discrete;
  };
}
