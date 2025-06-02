# nixos-config/systems/desknix-daily/iwgtk.nix
# Configure iwgtk for system 'daily' on host 'desknix'.
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
