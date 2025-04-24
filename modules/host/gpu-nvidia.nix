# Configuration for host module "gpu-nvidia".
# https://wiki.nixos.org/wiki/Graphics
# https://wiki.nixos.org/wiki/NVIDIA
{ config, lib, ... }:
let
  cfg = config.build.host.gpu;
in
{
  options = {
    build.host.gpu = {
      maker = lib.mkOption { type = lib.types.nullOr (lib.types.enum [ "nvidia" ]); };

      driver = lib.mkOption {
        description = "Nvidia GPU driver version.";
        type = lib.types.str;
        default = "stable";
        example = "beta";
      };

      openModules = lib.mkEnableOption (
        "open source kernel modules. Enabling this may cause loss of output"
        + " from GPU when waking from sleep"
      );
    };
  };

  config = lib.mkIf (cfg.maker == "nvidia") {
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
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.driver};
      open = cfg.openModules;

      # Fix graphics corruption when waking from sleep.
      powerManagement.enable = true;
    };
  };
}
