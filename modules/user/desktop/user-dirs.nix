{ config, lib, ... }:
let
  cfg = config.mp222.userDirs;
in
{
  options.mp222.userDirs = {
    enable = lib.mkEnableOption "XDG user directories";
  };

  config = lib.mkIf cfg.enable {
    xdg.userDirs =
      let
        # Sweep all this useless clutter under a rug.
        dirsPrefix = "${config.home.homeDirectory}/.udirs";
      in
      {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
        # All paths should always be lowercase.
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
