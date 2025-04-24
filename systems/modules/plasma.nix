# Configuration for system module "plasma".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.build.system.plasma;
in
{
  options = {
    build.system.plasma = {
      enable = lib.mkOption {
        description = "Enable KDE Plasma 6";
        type = lib.types.bool;
        default = false;
      };

      excludePackages = lib.mkOption {
        description = "List of Plasma 6 packages not to be installed by default.";
        type = lib.types.listOf lib.types.package;
        default = [ ];
        example = [ pkgs.kdePackages.kate ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = cfg.excludePackages;
  };
}
