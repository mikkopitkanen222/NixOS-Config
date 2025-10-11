# https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = with pkgs; [ brightnessctl ];

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          # Dim display after inactivity.
          {
            timeout = builtins.toString (9 * 60);
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          # Lock screen after inactivity.
          {
            timeout = builtins.toString (10 * 60);
            on-timeout = "loginctl lock-session";
          }
          # Turn off display after inactivity.
          {
            timeout = builtins.toString (30 + 10 * 60);
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
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
