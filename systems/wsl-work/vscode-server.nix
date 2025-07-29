# nixos-config/systems/wsl-work/vscode-server.nix
# Patch the VSCode server NodeJS binary for system 'work' on host 'wsl'.
# https://github.com/nix-community/nixos-vscode-server
{ inputs, ... }:
{
  imports = [ inputs.vscode-server.nixosModules.default ];
  services.vscode-server.enable = true;
}
