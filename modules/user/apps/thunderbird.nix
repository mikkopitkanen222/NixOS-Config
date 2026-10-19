{ config, lib, ... }:
let
  cfg = config.mp222.thunderbird;
in
{
  options.mp222.thunderbird = {
    enable = lib.mkEnableOption "Thunderbird";
  };

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles.${config.home.username} = {
        isDefault = true;
      };
    };
  };
}
