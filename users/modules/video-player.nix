# Configuration for user module "video-player".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.video-player = {
      enable = lib.mkEnableOption "video-player";

      package = lib.mkPackageOption pkgs "video-player" { default = [ "vlc" ]; };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.video-player;
    in
    lib.mkIf module.enable { home.packages = [ module.package ]; };

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}
