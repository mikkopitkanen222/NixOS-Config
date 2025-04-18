# Enable Spotify.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.build.users.spotify;

  userType = lib.types.submodule {
    options = {
      enable = lib.mkEnableOption "Spotify.";
    };
  };
in
{
  options.build.users = {
    spotify = lib.mkOption {
      description = "Spotify options for each user.";
      type = lib.types.attrsOf userType;
      default = { };
    };
  };

  config.unfree.allowedPackages = [ "spotify" ];

  config.home-manager.users = builtins.mapAttrs (
    name: value:
    lib.mkIf value.enable {
      home.packages = with pkgs; [
        spotify
        spicetify-cli
      ];
    }
  ) cfg;
}
