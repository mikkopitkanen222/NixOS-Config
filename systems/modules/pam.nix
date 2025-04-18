# Enable smartcard in place of password.
{ config, lib, ... }:
let
  cfg = config.build.software.pam;
in
{
  options.build.software.pam = {
    enable = lib.mkOption {
      description = "Enable PAM";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    security.pam.services = {
      login.u2fAuth = true;
      kde.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
