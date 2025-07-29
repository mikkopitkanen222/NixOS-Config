# nixos-config/users/lapnix-mp/user-dirs.nix
# Configure XDG user directories for user 'mp' on host 'lapnix'.
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

        # No switch exists that disables localization of default directory names,
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
  };
}
