{ lib, ... }:
{
  networking = {
    wireless.iwd = {
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
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = lib.mkDefault true;
  };

  programs.nm-applet.enable = true;
}
