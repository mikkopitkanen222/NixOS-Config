# Configure btop, a monitor of resources.
# https://github.com/aristocratos/btop
#
# This module can be imported by user "mp" config.
{ ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "flat-remix";
      theme_background = false;
      update_ms = 2000;
      clock_format = "20%y-%m-%d %X";
      cpu_graph_upper = "total";
      cpu_single_graph = true;
      io_mode = true;
      proc_left = true;
      proc_sorting = "cpu lazy";
      proc_per_core = true;
    };
  };
}
