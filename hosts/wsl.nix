# wsl host configuration.
{
  config,
  inputs,
  lib,
  ...
}:
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
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  config = lib.mkMerge [
    ({ system.hostNames' = [ hostName ]; })
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
