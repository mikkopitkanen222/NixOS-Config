# https://github.com/aristocratos/btop
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.btop;
in
{
  options.mp222.btop = {
    enable = lib.mkEnableOption "btop";
    rocmSupport = lib.mkEnableOption "rocm support";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      package = lib.mkDefault pkgs.btop.override { inherit (cfg) rocmSupport; };
      settings = {
        color_theme = lib.mkDefault "horizon";
        theme_background = lib.mkDefault false;
        shown_boxes = lib.mkDefault "cpu mem net proc gpu0";
        update_ms = lib.mkDefault 1000;
        clock_format = lib.mkDefault "20%y-%m-%d %X";
        cpu_graph_upper = lib.mkDefault "total";
        cpu_single_graph = lib.mkDefault true;
        cpu_sensor = lib.mkDefault "k10temp/Tctl";
        gpu_mirror_graph = lib.mkDefault false;
        custom_gpu_name0 = lib.mkDefault "RX 9070 XT";
        io_mode = lib.mkDefault true;
        proc_left = lib.mkDefault true;
        proc_sorting = lib.mkDefault "cpu lazy";
        proc_per_core = lib.mkDefault true;
      };
    };
  };
}
