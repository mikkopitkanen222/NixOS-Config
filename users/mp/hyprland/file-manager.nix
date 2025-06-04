# Configure a file manager.
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
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
      mappings = {
        c = "fzcd";
        f = "finder";
        v = "imgview";
      };
    };
  };
}
