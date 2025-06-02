# Configure iwgtk, a wireless networking GUI.
# https://github.com/j-lentz/iwgtk
#
# This module can be imported by system "main" config.
{ pkgs, ... }:
{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    iwgtk
  ];
}
