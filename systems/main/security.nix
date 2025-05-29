# Configure security and remote access settings.
#
# This module can be imported by system "main" config.
{ ... }:
{
  security.pam.services = {
    login.u2fAuth = true;
    kde.u2fAuth = true;
    sudo.u2fAuth = true;
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
