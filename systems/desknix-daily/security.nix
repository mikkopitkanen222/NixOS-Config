# nixos-config/systems/desknix-daily/security.nix
# Configure local and remote access for system 'daily' on host 'desknix'.
{ config, ... }:
{
  security.pam = {
    u2f = {
      enable = true;
      settings = {
        origin = "pam://mp222";
        authfile = config.sops.secrets."u2f_keys".path;
        cue = true;
      };
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };

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
