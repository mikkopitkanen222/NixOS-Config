{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.mp = {
    isNormalUser = lib.mkDefault true;

    hashedPasswordFile = config.sops.secrets."passwd_mp".path;
    shell = lib.mkDefault pkgs.zsh;
  };
}
