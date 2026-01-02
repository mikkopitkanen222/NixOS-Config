{ config, ... }:
{
  security.pam = {
    u2f = {
      enable = true;
      settings = {
        origin = "pam://mp222";
        authfile = config.sops.secrets."u2f_keys".path;
        pinverification = 1;
        cue = true;
      };
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };

  security.sudo.configFile = ''
    Defaults timestamp_timeout=15
  '';

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
}
