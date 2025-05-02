# Configuration for host "wsl".
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

    build.host = {
      cpu.maker = null;
      gpu.maker = null;
    };
  };
in
{
  options = {
    build.hostName = lib.mkOption { type = lib.types.enum [ hostName ]; };
  };

  config = lib.mkIf (config.build.hostName == hostName) hostConfig;
}
