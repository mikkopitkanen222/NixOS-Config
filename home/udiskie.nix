# https://github.com/coldfix/udiskie
{ config, lib, ... }:
let
  cfg = config.mp222.clipse;
in
{
  services.udisks2.enable = true;

  home-manager.users.mp = {
    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
        program_options = {
          udisks_version = 2;
          automount = true;
          notify = true;
          password_cache = 5;
          password_prompt = "builtin:tty";
        };
      };
    };
  };
}
