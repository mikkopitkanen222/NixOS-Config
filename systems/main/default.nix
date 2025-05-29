# Configuration for system "main".
{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./games.nix
    ./pipewire.nix
    ./security.nix
    ../shared/common.nix
    ../shared/locale.nix
    ../shared/smartcard-crypto.nix
    ../shared/vscode-server.nix
  ];

  environment.systemPackages = with pkgs; [ tree ];
}
