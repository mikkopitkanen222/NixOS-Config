{ config, lib, ... }:
let
  cfg = config.mp222.networkmanager;
in
{
  options.mp222.networkmanager = {
    enable = lib.mkEnableOption "NetworkManager";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi = {
          backend = "iwd";
          powersave = lib.mkIf config.mp222.host.isLaptop true;
        };
      };
      wireless.iwd = {
        enable = true;
        settings = {
          Network.EnableIPv6 = true;
          Settings.AutoConnect = true;
        };
      };
    };

    programs.nm-applet.enable = true;

    users.users = lib.mapAttrs (_: _: {
      extraGroups = [
        "netdev"
        "networkmanager"
      ];
    }) config.mp222.users;
  };
}
