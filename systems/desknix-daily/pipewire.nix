# nixos-config/systems/desknix-daily/pipewire.nix
# Configure audio and screen capture for system 'daily' on host 'desknix'.
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
