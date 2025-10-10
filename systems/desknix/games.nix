{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mp222 = {
    enableFactorio = lib.mkEnableOption "the headless Factorio service";
  };

  config = lib.mkMerge [
    { programs.steam.enable = true; }
    (lib.mkIf config.mp222.enableFactorio {
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
    })
  ];
}
