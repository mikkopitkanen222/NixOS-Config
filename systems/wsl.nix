# Configuration for system "wsl".
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
    build.system.locale.enable = true;
    build.system.scCrypto.enable = true;
    build.system.systemDefaults.enable = true;

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
