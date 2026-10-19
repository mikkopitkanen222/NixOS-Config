# https://github.com/nix-community/nixos-vscode-server
{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mp222.vscodeServer;
in
{
  imports = [ inputs.vscode-server.nixosModules.default ];

  options.mp222.vscodeServer = {
    enable = lib.mkEnableOption "VS Code Server";
  };

  config = lib.mkIf cfg.enable { services.vscode-server.enable = true; };
}
