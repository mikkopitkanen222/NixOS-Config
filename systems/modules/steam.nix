# Configuration for system module "steam".
{ config, lib, ... }:
let
  cfg = config.build.system.steam;
in
{
  options.build.system.steam = {
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
