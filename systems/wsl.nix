# wsl system configuration.
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  systemName = "wsl";

  systemConfig = {
    services.vscode-server.enable = true;

    system.software.locale.enable = true;
    system.software.scCrypto.enable = true;
    system.software.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [
      tree
    ];
  };
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.vscode-server.nixosModules.default
  ];

  config = lib.mkMerge [
    ({ system.systemNames' = [ systemName ]; })
    (lib.mkIf (config.system.systemName == systemName) systemConfig)
  ];
}
