# main system configuration.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  systemName = "main";

  systemConfig = {
    services.vscode-server.enable = true;

    build.software.audio.enable = true;
    build.software.locale.enable = true;
    build.software.openssh.enable = true;
    build.software.pam.enable = true;
    build.software.plasma.enable = true;
    build.software.scCrypto.enable = true;
    build.software.sddm.enable = true;
    build.software.steam.enable = true;
    build.software.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [ tree ];
  };
in
{
  options = {
    build.systemName = lib.mkOption { type = lib.types.enum [ systemName ]; };
  };

  config = lib.mkIf (config.build.systemName == systemName) systemConfig;
}
