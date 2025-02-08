# User specific Git config.
{ ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      userName = "Mikko Pitkänen";
      userEmail = "mikko.pitkanen@quux.fi";
      signing.signByDefault = true;
      signing.key = "66E93779B6C5AA0A!";
    };
  };
}
