# Configuration for user module "spotify".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.spotify = {
      enable = lib.mkEnableOption "spotify";

      package = lib.mkPackageOption pkgs "spotify" { };

      spicetify.enable = lib.mkEnableOption "spicetify";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.spotify;
    in
    lib.mkMerge [
      (lib.mkIf module.enable { home.packages = [ module.package ]; })
      (lib.mkIf (module.enable && module.spicetify.enable) { home.packages = [ pkgs.spicetify-cli ]; })
    ];

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    unfree.allowedPackages = [ "spotify" ];
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}
