# Allow secure remote login.
{ ... }:
{
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
