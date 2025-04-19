# Configuration for user module "protonpass".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.protonpass = {
      enable = lib.mkEnableOption "protonpass";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.protonpass;
    in
    lib.mkIf module.enable { home.packages = [ pkgs.proton-pass ]; };

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
