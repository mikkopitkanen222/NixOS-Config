{ lib, ... }: {
  home-manager.users.mp = hm: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Mikko Pitkänen";
          email = "mikko.pitkanen.code@pm.me";
        };
        core = {
          editor = lib.mkIf hm.config.programs.vscodium.enable "codium --wait";
          pager = "less -x2";
        };
        init.defaultBranch = "master";
      };
      signing.signByDefault = true;
    };
  };
}
