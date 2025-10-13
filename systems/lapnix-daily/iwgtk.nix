# https://github.com/j-lentz/iwgtk
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
