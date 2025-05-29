# Patch the VSCode server NodeJS binary to work on NixOS.
# https://github.com/nix-community/nixos-vscode-server
#
# This module can be imported by all system configs.
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
