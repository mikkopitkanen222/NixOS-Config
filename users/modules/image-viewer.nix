# Configuration for user module "image-viewer".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.image-viewer = {
      enable = lib.mkEnableOption "image-viewer";

      package = lib.mkPackageOption pkgs "image-viewer" { default = [ "qimgv" ]; };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.image-viewer;
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
