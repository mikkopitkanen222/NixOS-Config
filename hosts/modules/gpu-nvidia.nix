# Enable Nvidia GPU.
# https://wiki.nixos.org/wiki/Graphics
# https://wiki.nixos.org/wiki/NVIDIA
{ config, lib, ... }:
let
  cfg = config.build.host.gpu;
in
{
  options.build.host.gpu = {
    nvidia = lib.mkOption {
      description = "Enable Nvidia GPU driver";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.nvidia {
    # Nvidia kernel modules require proprietary userspace libraries.
    unfree.allowedPackages = [
      "nvidia-x11"
      "nvidia-settings"
    ];

    # Enable Nvidia kernel modules for X and Wayland.
    services.xserver.videoDrivers = [ "nvidia" ];

    # Install Mesa (OpenGL & Vulkan drivers).
    hardware.graphics.enable = true;

    hardware.nvidia = {
      # Select driver version. Currently > 570.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Enable kernel modesetting when using proprietary drivers.
      # Wayland requires this and driver version >= 545.
      # Enabled by default on driver versions >= 535.
      modesetting.enable = true;

      # RTX 2070 supports open source kernel modules,
      # but there's no output from GPU when waking from sleep.
      open = false;

      # RTX 2070 supports the GPU System Processor, which is required
      # (and enabled by default) when using open source kernel modules.
      gsp.enable = true;

      # Fix graphics corruption when waking from sleep.
      powerManagement.enable = true;
    };
  };
}
