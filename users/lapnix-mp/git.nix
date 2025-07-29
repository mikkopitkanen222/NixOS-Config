# nixos-config/users/lapnix-mp/git.nix
# Configure Git for user 'mp' on host 'lapnix'.
{ ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      userName = "Mikko Pitkänen";
      userEmail = "mikko.pitkanen.code@pm.me";
      signing.signByDefault = true;
      extraConfig = {
        core.pager = "less -x2";
        init.defaultBranch = "master";
      };
    };
  };
}
