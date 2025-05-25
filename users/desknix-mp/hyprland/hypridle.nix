# nixos-config/users/desknix-mp/hyprland/hypridle.nix
# Configure Hypridle for user 'mp' on host 'desknix'.
# https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
{ ... }:
{
  home-manager.users.mp = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          # Lock screen after inactivity.
          {
            timeout = builtins.toString (10 * 60);
            on-timeout = "loginctl lock-session";
          }
          # Turn off display after inactivity.
          {
            timeout = builtins.toString (30 + 10 * 60);
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          # Suspend machine after inactivity.
          {
            timeout = builtins.toString (20 * 60);
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
