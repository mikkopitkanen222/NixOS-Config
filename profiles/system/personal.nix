{ config, lib, ... }:
let
  cfg = config.mp222.profiles.personal;
in
{
  options.mp222.profiles.personal = {
    enable = lib.mkEnableOption "the personal system profile";
  };

  config = lib.mkIf cfg.enable {
    mp222 = lib.mkDefault {
      # Apps
      steam.enable = true;
    };
  };
}
