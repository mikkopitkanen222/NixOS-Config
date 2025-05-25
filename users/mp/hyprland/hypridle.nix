# Configure hypridle.
# https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/
#
# This module can be imported by user "mp" Hyprland config.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    hypridle
  ];

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
          timeout = "600";
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # Lock screen after inactivity.
        {
          timeout = "900";
          on-timeout = "loginctl lock-session";
        }
        # Turn off display after inactivity.
        {
          timeout = "930";
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        # Suspend machine after inactivity.
        {
          timeout = "1800";
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
