# Configuration for host "wsl".
{ config, lib, ... }:
let
  # Build this host by setting the attribute "system.hostName" in flake.nix.
  hostName = "wsl";

  # Configure hardware, disks, and other device specific options:
  hostConfig = lib.mkMerge [
    # Versions
    { system.stateVersion = "24.11"; }
    # WSL
    {
      wsl = {
        enable = true;
        wslConf.network.hostname = hostName;
      };
    }
  ];
in
{
  config = lib.mkMerge [
    # Merge this host's hostName to the list of all hostNames.
    ({ system.allHostNames = [ hostName ]; })
    # Build this host's configuration if its hostName is set in flake.nix.
    (lib.mkIf (config.system.hostName == hostName) hostConfig)
  ];
}
