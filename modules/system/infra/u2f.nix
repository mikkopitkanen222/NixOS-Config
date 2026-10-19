{ config, lib, ... }:
let
  cfg = config.mp222.u2f;
in
{
  options.mp222.u2f = {
    enable = lib.mkEnableOption "U2F authentication for login and sudo";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.u2f_keys = {
      group = "users";
      mode = "0440";
    };

    security.pam = {
      u2f = {
        enable = true;
        settings = {
          origin = "pam://mp222";
          authfile = config.sops.secrets.u2f_keys.path;
          pinverification = 1;
          cue = true;
        };
      };
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };

    # PIN verification makes every sudo slower, so ask less often than the
    # default 5 minutes.
    security.sudo.extraConfig = ''
      Defaults timestamp_timeout=15
    '';
  };
}
