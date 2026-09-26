{ config, lib, ... }:
let
  cfg = config.mp222.btrfs;
in
{
  options.mp222.btrfs = {
    enableAutoScrub = lib.mkEnableOption "BTRFS auto scrub";
    enableSnapper = lib.mkEnableOption "BTRFS snapper";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableAutoScrub {
      services.btrfs.autoScrub = {
        enable = true;
        interval = lib.mkDefault "weekly";
        fileSystems = [ "/" ];
      };
    })
    (lib.mkIf cfg.enableSnapper {
      services.snapper = {
        snapshotInterval = lib.mkDefault "hourly";
        cleanupInterval = lib.mkDefault "1h";
        configs = lib.mkDefault {
          "root" = {
            SUBVOLUME = "/";
            ALLOW_USERS = [ "mp" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 6;
            TIMELINE_LIMIT_MONTHLY = 0;
            TIMELINE_LIMIT_YEARLY = 0;
          };
          "nix" = {
            SUBVOLUME = "/nix";
            ALLOW_USERS = [ "mp" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_MONTHLY = 0;
            TIMELINE_LIMIT_YEARLY = 0;
          };
          "home" = {
            SUBVOLUME = "/home";
            ALLOW_USERS = [ "mp" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
            TIMELINE_LIMIT_HOURLY = 8;
            TIMELINE_LIMIT_DAILY = 5;
            TIMELINE_LIMIT_MONTHLY = 0;
            TIMELINE_LIMIT_YEARLY = 0;
          };
          "persist" = {
            SUBVOLUME = "/persist";
            ALLOW_USERS = [ "mp" ];
            TIMELINE_CREATE = true;
            TIMELINE_CLEANUP = true;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 7;
            TIMELINE_LIMIT_WEEKLY = 6;
            TIMELINE_LIMIT_MONTHLY = 0;
            TIMELINE_LIMIT_YEARLY = 0;
          };
        };
      };
    })
  ];
}
