# Configuration for system module "factorio".
{ config, lib, ... }:
let
  cfg = config.build.system.factorio;
in
{
  options = {
    build.system.factorio = {
      enable = lib.mkEnableOption "Factorio headless server";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ config.services.factorio.package ];
    unfree.allowedPackages = [ (lib.getName config.services.factorio.package) ];

    services.factorio = rec {
      enable = true;
      requireUserVerification = false;
      saveName = "SPAGEtti";
      openFirewall = true;
      nonBlockingSaving = true;
      loadLatestSave = true;
      game-name = "SPAGEtti";
      extraSettingsFile = "/var/lib/${config.services.factorio.stateDirName}/${game-name}-settings";
      extraSettings = {
        max_players = 2;
      };
      description = "foofoo";
      autosave-interval = 3;
      admins = [
        "Mikkeli222"
        "Valdos"
      ];
    };
  };
}
