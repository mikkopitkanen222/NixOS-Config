# Configuration for system "main".
{ pkgs, ... }:
{
  imports = [
    ./bluetooth.nix
    ./games.nix
    ./hyprland.nix
    ./pipewire.nix
    ./security.nix
    ./wireless.nix
    ../shared/common.nix
    ../shared/locale.nix
    ../shared/smartcard-crypto.nix
    ../shared/vscode-server.nix
  ];

  environment.systemPackages = with pkgs; [ tree ];
}
