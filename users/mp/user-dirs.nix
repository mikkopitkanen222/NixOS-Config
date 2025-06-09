# Configure XDG user directories.
#
# This module can be imported by user "mp" config.
{ config, ... }:
{
  xdg.userDirs =
    let
      dirsPrefix = "${config.home.homeDirectory}/.udirs";
    in
    {
      enable = true;
      createDirectories = true;

      # There's no switch that prevents default directory names being localized,
      # for some mentally delayed reason. LC_ALL can be used to force English
      # names [Arch Wiki], but I'll instead take this opportunity to also hide
      # these dirs. I don't use them anyway, but some apps do. Also, paths
      # should be all lowercase.
      desktop = "${dirsPrefix}/desktop";
      documents = "${dirsPrefix}/documents";
      download = "${dirsPrefix}/downloads";
      music = "${dirsPrefix}/music";
      pictures = "${dirsPrefix}/pictures";
      publicShare = "${dirsPrefix}/public";
      templates = "${dirsPrefix}/templates";
      videos = "${dirsPrefix}/videos";
    };
}
