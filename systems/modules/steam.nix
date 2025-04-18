# Enable Steam.
{ config, lib, ... }:
let
  cfg = config.build.software.steam;
in
{
  options.build.software.steam = {
    enable = lib.mkOption {
      description = "Enable Steam";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    unfree.allowedPackages = [
      "steam"
      "steam-unwrapped"
    ];

    programs.steam.enable = true;
  };
}
