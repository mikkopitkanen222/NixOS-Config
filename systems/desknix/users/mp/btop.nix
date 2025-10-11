# https://github.com/aristocratos/btop
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.btop = {
      enable = true;
      package = pkgs.btop.override { rocmSupport = true; };
      # Below are just the changes to default btop settings.
      settings = {
        color_theme = "horizon";
        theme_background = false;
        shown_boxes = "cpu mem net proc gpu0";
        update_ms = 1000;
        clock_format = "20%y-%m-%d %X";
        cpu_graph_upper = "total";
        cpu_single_graph = true;
        cpu_sensor = "k10temp/Tctl";
        gpu_mirror_graph = false;
        custom_gpu_name0 = "RX 9070 XT";
        io_mode = true;
        proc_left = true;
        proc_sorting = "cpu lazy";
        proc_per_core = true;
      };
    };
  };
}
