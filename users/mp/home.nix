# Home-manager configuration for user "mp".
{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = "mp";
    homeDirectory = "/home/mp";
    stateVersion = "24.11";
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
    spicetify-cli # Remove, see spotify
    spotify # Switch to spotify-player & conf through HM
    vlc
    # Messengers
    vesktop # Conf through HM
    whatsie
    # Work
    hunspell
    hunspellDicts.en_US
    kitty # Conf through HM
    libreoffice-qt6-fresh
    nixd
    obsidian
    qalculate-qt
  ];

  imports = [
    ./bash.nix
    ./git.nix
    ./internet.nix
    ./proton-drive.nix
    ./proton-mail.nix
    ./thunderbird.nix
    ./vscode.nix
  ];
}
