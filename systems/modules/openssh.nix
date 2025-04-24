# Configuration for system module "openssh".
{ config, lib, ... }:
let
  cfg = config.build.system.openssh;
in
{
  options = {
    build.system.openssh = {
      enable = lib.mkOption {
        description = "Enable OpenSSH logins";
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        # Allow login using crypto keys only.
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;

        # Root user does not need to login remotely.
        PermitRootLogin = "no";
      };
    };
  };
}
