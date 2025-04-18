# wsl host configuration.
{ config, lib, ... }:
let
  hostName = "wsl";

  hostConfig = {
    system.stateVersion = "24.11";

    wsl = {
      enable = true;
      wslConf.network.hostname = hostName;
    };
  };
in
{
  options = {
    build.hostName = lib.mkOption { type = lib.types.enum [ hostName ]; };
  };

  config = lib.mkIf (config.build.hostName == hostName) hostConfig;
}
