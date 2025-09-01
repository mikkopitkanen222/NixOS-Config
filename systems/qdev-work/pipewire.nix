# nixos-config/systems/qdev-work/pipewire.nix
# Configure audio and screen capture for system 'work' on host 'qdev'.
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
