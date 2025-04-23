# wsl host configuration.
{ config, lib, ... }:
let
  hostName = "wsl";

  hostConfig = {
    system.stateVersion = "24.11";

    wsl = {
      enable = true;
      wslConf.network.hostname = hostName;
      defaultUser = builtins.head config.build.userNames;
    };

    build.host.usbip = {
      enable = true;
      autoAttach = [
        "5-1"
        "7-2"
      ];
    };
  };
in
{
  options = {
    build.hostName = lib.mkOption { type = lib.types.enum [ hostName ]; };
  };

  config = lib.mkIf (config.build.hostName == hostName) hostConfig;
}
