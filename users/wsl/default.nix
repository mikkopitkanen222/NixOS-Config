# Configuration for user "wsl".
{ ... }:
{
  imports = [ ./home.nix ];

  users.users.wsl = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
