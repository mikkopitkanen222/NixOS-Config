{ ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Mikko Pitkänen";
          email = "mikko.pitkanen.code@pm.me";
        };
        core.pager = "less -x2";
        init.defaultBranch = "master";
      };
      signing.signByDefault = true;
    };
  };
}
