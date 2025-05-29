# Configuration for host "wsl".
{ inputs, lib, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  wsl = {
    enable = true;
    wslConf.network.hostname = "wsl";
  };

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
