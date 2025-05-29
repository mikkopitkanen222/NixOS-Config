# Configuration for host "wsl".
{ ... }:
{
  system.stateVersion = "24.11";

  wsl = {
    enable = true;
    wslConf.network.hostname = "wsl";
  };
}
