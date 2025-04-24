# Configuration for user module "thunderbird".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      thunderbird = {
        enable = lib.mkEnableOption "thunderbird";
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.thunderbird;
    in
    lib.mkIf module.enable {
      programs.thunderbird = {
        enable = true;
        profiles.${user} = {
          isDefault = true;
        };
      };
    };

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
