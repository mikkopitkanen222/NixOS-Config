{ config, lib, ... }:
{
  imports = [ ../../../desknix/users/mp/git.nix ];

  home-manager.users.mp.programs.git = {
    signing.signByDefault = lib.mkForce false;
    extraConfig.init.defaultBranch = lib.mkForce "main";
    includes = [ { path = config.sops.templates."secret-gitconfig".path; } ];
  };

  sops.templates."secret-gitconfig" = {
    content = ''
      [user]
      email = "${config.sops.placeholder."work_email"}"
    '';
    owner = config.users.users.mp.name;
  };
}
