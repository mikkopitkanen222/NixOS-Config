# Enable graphical login screen.
{ config, lib, ... }:
let
  cfg = config.build.software.sddm;
in
{
  options.build.software.sddm = {
    enable = lib.mkOption {
      description = "Enable SDDM";
      type = lib.types.bool;
      default = false;
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
