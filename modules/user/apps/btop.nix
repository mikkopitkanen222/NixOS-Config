# https://github.com/aristocratos/btop
{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.mp222.btop;

  inherit (osConfig.mp222.host) amdGpuName cpuTempSensor;

  hasAmdGpu = amdGpuName != null;
in
{
  options.mp222.btop = {
    enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      package = pkgs.btop.override { rocmSupport = hasAmdGpu; };
      settings = {
        color_theme = "horizon";
        theme_background = false;
        shown_boxes = "cpu mem net proc" + lib.optionalString hasAmdGpu " gpu0";
        update_ms = 1000;
        clock_format = "%Y-%m-%d %X";
        cpu_graph_upper = "total";
        cpu_single_graph = true;
        cpu_sensor = if cpuTempSensor != null then cpuTempSensor else "";
        gpu_mirror_graph = false;
        custom_gpu_name0 = if hasAmdGpu then amdGpuName else "";
        io_mode = true;
        proc_left = true;
        proc_sorting = "cpu lazy";
        proc_per_core = true;
      };
    };
  };
}
