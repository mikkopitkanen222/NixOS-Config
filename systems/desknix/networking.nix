{ lib, pkgs, ... }:
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

  # nm-applet MUST be installed like this or the icons won't be found!
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
