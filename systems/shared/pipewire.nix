# Configure audio and screen capture.
#
# This module can be imported by all system configs.
{ ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
