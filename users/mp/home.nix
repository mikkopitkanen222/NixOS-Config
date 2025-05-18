# Home-manager configuration for user "mp".
{ pkgs, ... }@args:
{
  programs.home-manager.enable = true;

  home = {
    username = "mp";
    homeDirectory = "/home/mp";
    stateVersion = "25.05";
  };

  gtk = {
    enable = true;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
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
    (import ./hyprland args)
    ./app-menu.nix
    ./automounter.nix
    ./bash.nix
    ./clipboard.nix
    ./discord.nix
    ./file-manager.nix
    ./git.nix
    ./internet.nix
    ./language.nix
    ./proton-drive.nix
    ./proton-mail.nix
    ./resource-monitor.nix
    ./spotify.nix
    (import ./status-bar.nix args)
    ./terminal.nix
    ./thunderbird.nix
    ./user-dirs.nix
    ./vscode.nix
  ];
}
