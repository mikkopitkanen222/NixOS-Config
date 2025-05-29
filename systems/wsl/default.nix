# Configuration for system "wsl".
{ pkgs, ... }:
{
  imports = [
    ../shared/common.nix
    ../shared/locale.nix
    ../shared/smartcard-crypto.nix
    ../shared/vscode-server.nix
  ];

  environment.systemPackages = with pkgs; [
    tree
    wget
  ];
}
