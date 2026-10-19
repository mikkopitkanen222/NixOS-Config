{ config, lib, ... }:
let
  cfg = config.mp222.pipewire;
in
{
  options.mp222.pipewire = {
    enable = lib.mkEnableOption "PipeWire audio";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
