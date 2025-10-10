# nixos-config/systems/lapnix/pipewire.nix
# Configure audio and screen capture on host 'lapnix'.
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
