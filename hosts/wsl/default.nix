# Wsl host configuration.
{ ... }:
{
  system.stateVersion = "24.11";

  wsl = {
    enable = true;
    wslConf.network.hostname = "wsl";
  };
}
