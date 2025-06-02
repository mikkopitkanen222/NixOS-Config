# Configuration for host "wsl".
{ inputs, lib, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  wsl = {
    enable = true;
    wslConf.network.hostname = "wsl";
  };

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
