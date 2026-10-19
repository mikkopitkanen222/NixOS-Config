{ config, lib, ... }:
let
  cfg = config.mp222.bluetooth;
in
{
  options.mp222.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
