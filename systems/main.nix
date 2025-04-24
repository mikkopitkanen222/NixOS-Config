# Configuration for system "main".
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

    build.system.audio.enable = true;
    build.system.locale.enable = true;
    build.system.openssh.enable = true;
    build.system.pam.enable = true;
    build.system.plasma = {
      enable = true;
      excludePackages = with pkgs.kdePackages; [
        elisa
        gwenview
        kate
        konsole
      ];
    };
    build.system.scCrypto.enable = true;
    build.system.sddm.enable = true;
    build.system.steam.enable = true;
    build.system.systemDefaults.enable = true;

    environment.systemPackages = with pkgs; [ tree ];
  };
in
{
  options = {
    build.systemName = lib.mkOption { type = lib.types.enum [ systemName ]; };
  };

  config = lib.mkIf (config.build.systemName == systemName) systemConfig;
}
