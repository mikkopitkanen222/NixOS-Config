{ config, lib, ... }:
let
  cfg = config.mp222.steam;
in
{
  options.mp222.steam = {
    enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf cfg.enable { programs.steam.enable = true; };
}
