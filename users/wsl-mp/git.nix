{ config, ... }:
{
  home-manager.users.mp = {
    programs.git = {
      enable = true;
      userName = "Mikko Pitkänen";
      extraConfig = {
        core.pager = "less -x2";
      };
      includes = [ { path = config.sops.templates."secret-gitconfig".path; } ];
    };
  };

  sops.templates."secret-gitconfig" = {
    content = ''
      [user]
      email = "${config.sops.placeholder."work_email"}"
    '';
    owner = config.users.users.mp.name;
  };
}
