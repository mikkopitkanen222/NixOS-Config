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
    build.software.locale.enable = true;
    build.software.scCrypto.enable = true;
    build.software.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [
      tree
      wget
    ];
  };
in
{
  options = {
    build.systemName = lib.mkOption { type = lib.types.enum [ systemName ]; };
  };

  config = lib.mkIf (config.build.systemName == systemName) systemConfig;
}
