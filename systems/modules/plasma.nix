# Enable KDE Plasma 6.
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
  options.build.system.plasma = {
    enable = lib.mkOption {
      description = "Enable KDE Plasma 6";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    # Disable unwanted packages enabled by default.
    environment.plasma6.excludePackages = with pkgs.kdePackages; [ kate ];
  };
}
