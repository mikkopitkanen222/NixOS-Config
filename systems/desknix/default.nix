# Configuration for system "desknix".
{ pkgs, ... }:
{
  imports = [
    ./games.nix
    ../shared/common.nix
    ../shared/desktop.nix
    ../shared/locale.nix
    ../shared/pipewire.nix
    ../shared/security.nix
    ../shared/smartcard-crypto.nix
    ../shared/vscode-server.nix
  ];

  environment.systemPackages = with pkgs; [ tree ];
}
