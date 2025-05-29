# Configuration for user "wsl".
{ ... }:
{
  users.users.wsl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.wsl = ./home.nix;
}
