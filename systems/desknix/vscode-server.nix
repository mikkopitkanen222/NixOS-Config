# nixos-config/systems/desknix/vscode-server.nix
# Patch the VSCode server NodeJS binary on host 'desknix'.
# https://github.com/nix-community/nixos-vscode-server
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
