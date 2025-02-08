# mp wsl user configuration.
{ pkgs, ... }:
let
  username = "mp";
in
{
  wsl.defaultUser = username;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  home-manager.users.${username} = {
    programs.home-manager.enable = true;
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "24.11";
    };
  };

  imports = [
    ./git.nix
  ];
}
