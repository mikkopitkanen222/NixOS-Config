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
  config = lib.mkMerge [
    ({ system.hostNames' = [ hostName ]; })
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
