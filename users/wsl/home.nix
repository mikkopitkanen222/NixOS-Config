# Home-manager configuration for user "wsl".
{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = "wsl";
    homeDirectory = "/home/wsl";
    stateVersion = "25.05";
  };

  # Lone packages without further config:
  home.packages = with pkgs; [ nixd ];

  imports = [
    ./bash.nix
    ./git.nix
    ./language.nix
  ];
}
