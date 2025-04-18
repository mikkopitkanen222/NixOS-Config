# Enable audio.
{ config, lib, ... }:
let
  cfg = config.build.software.audio;
in
{
  options.build.software.audio = {
    enable = lib.mkOption {
      description = "Enable audio services";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the RealtimeKit system service.
    # PipeWire requires this to acquire realtime priority.
    security.rtkit.enable = true;

    # PipeWire isn't just a sound server, it can also capture video.
    services.pipewire = {
      # This enables WirePlumber by default.
      enable = true;

      # ALSA is the raw audio interface.
      alsa = {
        # This enables PipeWire as the primary sound server by default.
        enable = true;
        support32Bit = true;
      };

      # Enable PulseAudio server emulation.
      # This enables PipeWire as the primary sound server by default.
      pulse.enable = true;
    };
  };
}
