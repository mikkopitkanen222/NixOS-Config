{ config, lib, ... }:
let
  cfg = config.mp222.udisks;
in
{
  options.mp222.udisks = {
    enable = lib.mkEnableOption "UDisks";
  };

  config = lib.mkIf cfg.enable { services.udisks2.enable = true; };
}
