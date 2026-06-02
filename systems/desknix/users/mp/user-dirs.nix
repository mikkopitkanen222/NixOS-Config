{ config, ... }:
{
  home-manager.users.mp = {
    xdg.userDirs =
      let
        dirsPrefix = "${config.home-manager.users.mp.home.homeDirectory}/.udirs";
      in
      {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;

        # For some mentally delayed reason, no switch exists to disable
        # localization of default directory names. LC_ALL can be used to force
        # English names [Arch Wiki], but I'll instead take this opportunity to
        # group this garbage under a hidden directory. I don't like knowing they
        # exist, but some apps do use them. Also, all paths should be lowercase.
        desktop = "${dirsPrefix}/desktop";
        documents = "${dirsPrefix}/documents";
        download = "${dirsPrefix}/downloads";
        music = "${dirsPrefix}/music";
        pictures = "${dirsPrefix}/pictures";
        projects = "${dirsPrefix}/projects";
        publicShare = "${dirsPrefix}/public";
        templates = "${dirsPrefix}/templates";
        videos = "${dirsPrefix}/videos";
      };
  };
}
