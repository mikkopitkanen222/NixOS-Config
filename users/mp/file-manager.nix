# Configure nnn, a terminal file manager.
# https://github.com/jarun/nnn
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, E, exec, kitty --class nnn -e 'nnn'"
  ];

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
}
