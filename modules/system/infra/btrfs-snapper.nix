{ config, lib, ... }:
let
  cfg = config.mp222.btrfs.snapper;

  admins = lib.attrNames (
    lib.filterAttrs (_: user: user.enable && user.admin) config.mp222.users
  );
in
{
  options = {
    mp222.btrfs.snapper = {
      enable = lib.mkEnableOption "btrfs timeline snapshots";
    };

    services.snapper.configs = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          config = lib.mkIf cfg.enable {
            ALLOW_USERS = lib.mkDefault admins;
            TIMELINE_CREATE = lib.mkDefault true;
            TIMELINE_CLEANUP = lib.mkDefault true;
            TIMELINE_LIMIT_HOURLY = lib.mkDefault 0;
            TIMELINE_LIMIT_DAILY = lib.mkDefault 0;
            TIMELINE_LIMIT_WEEKLY = lib.mkDefault 0;
            TIMELINE_LIMIT_MONTHLY = lib.mkDefault 0;
            TIMELINE_LIMIT_QUARTERLY = lib.mkDefault 0;
            TIMELINE_LIMIT_YEARLY = lib.mkDefault 0;
          };
        }
      );
    };
  };

  config = lib.mkIf cfg.enable {
    services.snapper.cleanupInterval = lib.mkDefault "1h";
  };
}
