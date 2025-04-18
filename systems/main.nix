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

    system.software.audio.enable = true;
    system.software.locale.enable = true;
    system.software.openssh.enable = true;
    system.software.pam.enable = true;
    system.software.plasma.enable = true;
    system.software.scCrypto.enable = true;
    system.software.sddm.enable = true;
    system.software.steam.enable = true;
    system.software.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [ tree ];
  };
in
{
  config = lib.mkMerge [
    ({ system.systemNames' = [ systemName ]; })
    (lib.mkIf (config.system.systemName == systemName) systemConfig)
  ];
}
