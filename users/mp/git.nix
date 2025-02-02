# User specific Git config.
{ ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      userName = "Mikko Pitkänen";
      userEmail = "mikko.pitkanen.code@pm.me";
      signing.signByDefault = true;

      # Let GnuPG pick the key based on email.
      signing.key = null;
    };
  };
}
