# Home-manager configuration for user "mp".
{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = "mp";
    homeDirectory = "/home/mp";
    stateVersion = "25.05";
  };

  # Lone packages without further config:
  home.packages = with pkgs; [
    # Downtime
    bolt-launcher
    # Image, Music & Video Editors
    gimp-with-plugins
    shotcut
    # Image, Music & Video Viewers
    qimgv
    vlc
    # Messengers
    whatsie
    # Work
    hunspell
    hunspellDicts.en_US
    libreoffice-qt6-fresh
    nixd
    obsidian
    qalculate-qt
  ];

  imports = [
    ./bash.nix
    ./discord.nix
    ./git.nix
    ./internet.nix
    ./language.nix
    ./proton-drive.nix
    ./proton-mail.nix
    ./spotify.nix
    ./terminal.nix
    ./thunderbird.nix
    ./user-dirs.nix
    ./vscode.nix
  ];
}
