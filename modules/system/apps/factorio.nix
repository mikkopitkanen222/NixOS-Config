{ config, lib, ... }:
let
  cfg = config.mp222.factorio;

  baseConfig = {
    enable = true;
    saveName = cfg.game;
    stateDirName = "factorio-" + cfg.game;
    openFirewall = true;
    loadLatestSave = true;
    autosave-interval = 5;
    nonBlockingSaving = true;
    extraSettings = {
      max_players = 5;
      ignore_player_limit_for_returning_players = true;
      afk_autokick_interval = 30;
    };
    # Provided by LoadCredential below.
    extraSettingsFile = "/run/credentials/factorio.service/extra-settings";
  };

  games = {
    SPAGEtti =
      let
        admins = [
          "Mikkeli222"
          "Valdos"
        ];
      in
      {
        inherit admins;
        allowedPlayers = admins;
      };
  };
in
{
  options.mp222.factorio = {
    enable = lib.mkEnableOption "the headless Factorio service";

    game = lib.mkOption {
      type = lib.types.enum (lib.attrNames games);
      default = "SPAGEtti";
      description = "Which game to host.";
    };

    settingsFile = lib.mkOption {
      type = lib.types.externalPath;
      example = "/run/secrets/factorio-extra-settings";
      description = ''
        A JSON file with the secret server settings, such as the game password.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.factorio = lib.mkMerge [
      baseConfig
      games.${cfg.game}
    ];

    # Only the service can read the secrets, though it runs as a dynamic user.
    systemd.services.factorio.serviceConfig.LoadCredential =
      "extra-settings:${cfg.settingsFile}";

    # Not required by the service, but allows CLI usage.
    environment.systemPackages = [ config.services.factorio.package ];
  };
}
