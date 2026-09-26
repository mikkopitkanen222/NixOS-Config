{ config, lib, ... }:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    programs.thunderbird = {
      enable = true;
      profiles.mp = {
        isDefault = true;
      };
    };
  };
}
