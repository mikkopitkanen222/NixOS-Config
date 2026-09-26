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

  config =
    let
      factorio = config.services.factorio;
    in
    lib.mkIf cfg.enable {
      services.factorio = {
        enable = true;
        package = pkgs.factorio-headless;
        requireUserVerification = false;
        saveName = "SPAGEtti";
        openFirewall = true;
        nonBlockingSaving = true;
        loadLatestSave = true;
        game-name = "SPAGEtti";
        extraSettingsFile = "/var/lib/${factorio.stateDirName}/${factorio.game-name}-settings";
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

      environment.systemPackages = [ factorio.package ];
    };
}
