# https://github.com/aristocratos/btop
{ ... }:
{
  home-manager.users.mp = {
    programs.btop = {
      enable = true;
      # Below are just the changes to default btop settings.
      settings = {
        color_theme = "horizon";
        theme_background = false;
        update_ms = 2000;
        clock_format = "20%y-%m-%d %X";
        cpu_graph_upper = "total";
        cpu_single_graph = true;
        cpu_sensor = "k10temp/Tctl";
        io_mode = true;
        proc_left = true;
        proc_sorting = "cpu lazy";
        proc_per_core = true;
      };
    };
  };
}
