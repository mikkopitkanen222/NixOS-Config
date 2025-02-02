# Enable Chromium browser integration with KDE Plasma.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plasmaBrowserIntegration;

  userType = lib.types.submodule {
    options = {
      enable = lib.mkEnableOption "the Plasma browser integration.";

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.kdePackages.plasma-browser-integration;
        description = "The host components which browsers integrate with.";
      };

      extension = lib.mkOption {
        type = lib.types.str;
        default = "cimiefiiaegbelhefglklhhakcgmhkai";
        description = "The browser extension which hosts integrate with.";
      };
    };
  };
in
{
  options = {
    plasmaBrowserIntegration = lib.mkOption {
      type = lib.types.attrsOf userType;
      default = { };
      description = "Plasma browser integration config for each user.";
    };
  };

  config = {
    home-manager.users = builtins.mapAttrs (
      name: value:
      lib.mkIf value.enable {
        home.packages = [ value.package ];
        programs.chromium.extensions = [ value.extension ];
      }
    ) cfg;
  };
}
