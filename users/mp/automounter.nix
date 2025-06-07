# Configure udiskie, a removable media automounter.
# https://github.com/coldfix/udiskie
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
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
}
