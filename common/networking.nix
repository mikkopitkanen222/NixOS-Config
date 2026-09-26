{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.networking;
in
{
  options.mp222.networking = {
    nman = {
      enable = lib.mkEnableOption "networkmanager";
      applet.enable = lib.mkEnableOption "nm-applet";
      backend = lib.mkOption {
        type = lib.types.str;
        description = "WiFi backend of networkmanager";
        default = "iwd";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.nman.enable {
      networking = {
        networkmanager = {
          enable = true;
          wifi.backend = cfg.nman.backend;
        };
        useDHCP = lib.mkDefault true;
      };
      mp222.host.extraGroups = [ "networkmanager" ];
    })
    (lib.mkIf (cfg.nman.enable && cfg.nman.applet.enable) {
      programs.nm-applet.enable = true;
      environment.systemPackages = [ pkgs.networkmanagerapplet ];
    })
    (lib.mkIf (cfg.nman.backend == "iwd") {
      networking.wireless.iwd = {
        enable = true;
        settings = {
          Network = {
            EnableIPv6 = true;
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
      mp222.host.extraGroups = [ "netdev" ];
    })
  ];
}
