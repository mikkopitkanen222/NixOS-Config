# nixos-config/users/qdev-mp/udiskie.nix
# Configure udiskie for user 'mp' on host 'qdev'.
# https://github.com/coldfix/udiskie
{ ... }:
{
  services.udisks2.enable = true;

  home-manager.users.mp = {
    services.udiskie = {
      enable = true;
      tray = "auto";
      settings = {
        program_options = {
          udisks_version = 2;
          automount = true;
          notify = true;
          password_cache = 5;
          password_prompt = "builtin:tty";
        };
      };
    };
  };
}
