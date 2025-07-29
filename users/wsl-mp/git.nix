# nixos-config/users/wsl-mp/git.nix
# Configure Git for user 'mp' on host 'wsl'.
{ ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      userName = "Mikko Pitkänen";
      userEmail = "change.me@work";
      extraConfig = {
        core.pager = "less -x2";
      };
    };
  };
}
