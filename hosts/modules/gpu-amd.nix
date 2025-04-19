# Enable AMD GPU.
{ config, lib, ... }:
let
  cfg = config.build.host.gpu;
in
{
  options.build.host.gpu = {
    amd = lib.mkOption {
      description = "Enable AMD GPU driver";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.amd {
    # Install Mesa (OpenGL & Vulkan drivers).
    hardware.graphics.enable = true;

    # Enable AMD kernel module.
    services.xserver.videoDrivers = [
      "amdvlk"
      "radv"
      "amdgpu"
    ];
  };
}
