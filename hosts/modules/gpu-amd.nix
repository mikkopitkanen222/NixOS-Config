# Enable AMD GPU.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system.hardware.gpu;
in
{
  options.system.hardware.gpu = {
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
