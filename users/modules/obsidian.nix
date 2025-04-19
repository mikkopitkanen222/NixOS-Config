# Configuration for user module "obsidian".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.obsidian = {
      enable = lib.mkEnableOption "obsidian";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.obsidian;
    in
    lib.mkIf module.enable { home.packages = [ pkgs.obsidian ]; };

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    unfree.allowedPackages = [ "obsidian" ];
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}
