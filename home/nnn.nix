# https://github.com/jarun/nnn
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.clipse;
in
{
  home-manager.users.mp = {
    programs.nnn = {
      enable = true;
      plugins = {
        src =
          (pkgs.fetchFromGitHub {
            owner = "jarun";
            repo = "nnn";
            rev = "v5.1";
            sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
          })
          + "/plugins";
      };
    };
  };
}
