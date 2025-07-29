# nixos-config/systems/lapnix-daily/vscode-server.nix
# Patch the VSCode server NodeJS binary for system 'daily' on host 'lapnix'.
# https://github.com/nix-community/nixos-vscode-server
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
