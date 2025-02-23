# Enable Chromium browser integration with KDE Plasma.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.system.users.plasmaBrowserIntegration;

  userType = lib.types.submodule {
    options = {
      enable = lib.mkEnableOption "the Plasma browser integration.";

      package = lib.mkOption {
        description = "The host components which browsers integrate with.";
        type = lib.types.package;
        default = pkgs.kdePackages.plasma-browser-integration;
      };

      extension = lib.mkOption {
        description = "The browser extension which hosts integrate with.";
        type = lib.types.str;
        default = "cimiefiiaegbelhefglklhhakcgmhkai";
      };
    };
  };
in
{
  options.system.users = {
    plasmaBrowserIntegration = lib.mkOption {
      description = "Plasma browser integration config for each user.";
      type = lib.types.attrsOf userType;
      default = { };
    };
  };

  config.home-manager.users = builtins.mapAttrs (
    name: value:
    lib.mkIf value.enable {
      home.packages = [ value.package ];
      programs.chromium.extensions = [ value.extension ];
    }
  ) cfg;
}
