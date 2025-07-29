# nixos-config/systems/lapnix-daily/pipewire.nix
# Configure audio and screen capture for system 'daily' on host 'lapnix'.
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
