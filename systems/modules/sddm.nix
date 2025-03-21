# Enable graphical login screen.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system.software.sddm;
in
{
  options.system.software.sddm = {
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
