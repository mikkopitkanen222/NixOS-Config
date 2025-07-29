# nixos-config/users/desknix-mp/git.nix
# Configure Git for user 'mp' on host 'desknix'.
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
