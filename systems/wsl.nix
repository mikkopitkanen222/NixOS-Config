# wsl system configuration.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  systemName = "wsl";

  systemConfig = {
    system.software.locale.enable = true;
    system.software.scCrypto.enable = true;
    system.software.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [
      tree
      wget
    ];
  };
in
{
  config = lib.mkMerge [
    ({ system.systemNames' = [ systemName ]; })
    (lib.mkIf (config.system.systemName == systemName) systemConfig)
  ];
}
