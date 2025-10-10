# nixos-config/systems/desknix/pipewire.nix
# Configure audio and screen capture on host 'desknix'.
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
