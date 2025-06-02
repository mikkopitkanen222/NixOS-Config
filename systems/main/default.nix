# Configuration for system "main".
{ pkgs, ... }:
{
  imports = [
    ./bluetooth.nix
    ./desktop.nix
    ./games.nix
    ./pipewire.nix
    ./security.nix
    ./wlan.nix
    ../shared/common.nix
    ../shared/locale.nix
    ../shared/smartcard-crypto.nix
    ../shared/vscode-server.nix
  ];

  environment.systemPackages = with pkgs; [ tree ];
}
