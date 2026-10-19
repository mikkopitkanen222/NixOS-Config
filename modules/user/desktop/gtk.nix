{ config, lib, ... }:
let
  cfg = config.mp222.gtk;
in
{
  options.mp222.gtk = {
    enable = lib.mkEnableOption "GTK theming";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
