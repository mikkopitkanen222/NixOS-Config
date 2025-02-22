# Enable secure remote login.
{
  config,
  lib,
  ...
}:
let
  cfg = config.system.software.openssh;
in
{
  options.system.software.openssh = {
    enable = lib.mkOption {
      description = "Enable OpenSSH logins";
      type = lib.types.bool;
      default = false;
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
