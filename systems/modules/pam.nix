# Enable smartcard in place of password.
{ ... }:
{
  security.pam.services = {
    login.u2fAuth = true;
    kde.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
