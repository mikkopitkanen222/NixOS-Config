# nixos-config/systems/desknix-daily/vscode-server.nix
# Patch the VSCode server NodeJS binary for system 'daily' on host 'desknix'.
# https://github.com/nix-community/nixos-vscode-server
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
