{ config, lib, ... }:
let
  cfg = config.mp222.btrfs.scrub;
in
{
  options.mp222.btrfs.scrub = {
    enable = lib.mkEnableOption "periodic btrfs scrubbing";
  };

  config = lib.mkIf cfg.enable {
    services.btrfs.autoScrub = {
      enable = true;
      interval = lib.mkDefault "weekly";
      fileSystems = [ "/" ];
    };
  };
}
