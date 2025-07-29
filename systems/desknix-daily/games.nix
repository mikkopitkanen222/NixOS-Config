# nixos-config/systems/desknix-daily/games.nix
# Configure games and game lauchers for system 'daily' on host 'desknix'.
{ config, pkgs, ... }:
{
  programs.steam.enable = true;

  services.factorio = rec {
    enable = true;
    package = pkgs.unstable.factorio-headless;
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
}
