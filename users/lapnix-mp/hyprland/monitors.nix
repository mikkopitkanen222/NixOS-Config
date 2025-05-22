# nixos-config/users/lapnix-mp/hyprland/monitors.nix
# Configure Hyprland outputs for user 'mp' on host 'lapnix'.
# https://wiki.hypr.land/Configuring/Monitors/
{ ... }:
{
  home-manager.users.mp = {
    wayland.windowManager.hyprland.settings = {
      monitorv2 = [
        # Basic laptop screen (1920x1080@60):
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
        # Default placement for extra monitors:
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "auto";
        }
      ];
    };
  };
}
