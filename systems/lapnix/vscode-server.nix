# nixos-config/systems/lapnix/vscode-server.nix
# Patch the VSCode server NodeJS binary on host 'lapnix'.
# https://github.com/nix-community/nixos-vscode-server
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
