{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.factorio;
in
{
  options.mp222.factorio = {
    enable = lib.mkEnableOption "the headless Factorio service";
  };

  config = lib.mkIf cfg.enable {
    services.factorio = rec {
      enable = true;
      package = pkgs.factorio-headless;
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

    environment.systemPackages = [ config.services.factorio.package ];
  };
}
