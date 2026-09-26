{ config, lib, ... }:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    gtk = {
      enable = true;
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
