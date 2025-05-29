# Configure games and game lauchers.
#
# This module can be imported by system "main" config.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.steam.enable = true;

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
  unfree.allowedPackages = [
    "steam"
    "steam-unwrapped"
    (lib.getName config.services.factorio.package)
  ];
}
