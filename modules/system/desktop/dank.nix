# https://github.com/AvengeMedia/DankMaterialShell
{ config, lib, ... }:
let
  cfg = config.mp222.dank;
in
{
  options.mp222.dank = {
    enable = lib.mkEnableOption "the services DMS needs";

    mainBar.screens = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "all" ];
      example = [
        "DP-1"
        "VG34VQ3B"
      ];
      description = ''
        List of monitors showing the main bar.
        Monitors are identified by their connector or model name.
        Use "all" to show on all monitors.
      '';
    };

    secondaryBar.screens = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "DP-1"
        "VG34VQ3B"
      ];
      description = ''
        List of monitors showing the secondary bar.
        Monitors are identified by their connector or model name.
        Use "all" to show on all monitors.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # These are normally enabled by DMS's nixosModule, but we use only the
    # homeModule.
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.accounts-daemon.enable = true;
  };
}
