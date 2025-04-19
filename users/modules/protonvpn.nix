# Configuration for user module "protonvpn".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.protonvpn = {
      enable = lib.mkEnableOption "protonvpn";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.protonvpn;
    in
    lib.mkIf module.enable { home.packages = [ pkgs.protonvpn-gui ]; };

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
