# Configuration for user "wsl".
{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.wsl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.wsl = import ./home.nix { inherit config lib pkgs; };
}
