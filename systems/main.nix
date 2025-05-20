# Configuration for system "main".
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  systemName = "main";

  systemConfig = {
    services.vscode-server.enable = true;

    build.system.audio.enable = true;
    build.system.factorio.enable = true;
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

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [ tree ];
  };
in
{
  options = {
    build.systemName = lib.mkOption { type = lib.types.enum [ systemName ]; };
  };

  config = lib.mkIf (config.build.systemName == systemName) systemConfig;
}
