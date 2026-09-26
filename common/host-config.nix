{ config, lib, ... }:
let
  cfg = config.mp222.host;

  userModule = lib.types.submodule {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Username";
      example = "mp";
    };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of extraGroups to add this user in.";
      default = [ ];
      example = [ "networkmanager" ];
    };
  };
in
{
  options.mp222.host = {
    users = lib.mkOption {
      type = lib.types.listOf userModule;
      description = "User configurations on this host.";
      example = [
        {
          name = "mp";
          extraGroups = [ "networkmanager" ];
        }
      ];
    };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of extraGroups to add all users in.";
      default = [ ];
      example = [ "networkmanager" ];
    };
  };

  config = {
    users.users = lib.listToAttrs (
      map (user: {
        inherit (user) name;
        value = {
          extraGroups = cfg.extraGroups ++ user.extraGroups;
        };
      }) cfg.users
    );
  };
}
