# Configuration for system module "sddm".
{ config, lib, ... }:
let
  cfg = config.build.system.sddm;
in
{
  options = {
    build.system.sddm = {
      enable = lib.mkOption {
        description = "Enable SDDM";
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      # Enable numlock after logging in.
      autoNumlock = true;
    };
  };
}
