# https://wiki.hyprland.org/Configuring/Variables/
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.pointerCursor = {
      hyprcursor.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = "3";
        gaps_in = "1";
        gaps_out = "2";
        "col.inactive_border" = "rgba(585858a8)";
        "col.active_border" = "rgba(54157ee0) rgba(d0a028e0) 90deg";
        layout = "dwindle";
      };

      decoration = {
        rounding = "15";
        rounding_power = "2.0";
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };
        shadow = {
          enabled = "true";
          range = "5";
          render_power = "4";
        };
      };

      animations = {
        enabled = "true";
        workspace_wraparound = "true";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = "true";
        preserve_split = "true";
      };

      misc = {
        disable_splash_rendering = "true";
        force_default_wallpaper = "2";
        vrr = "2";
        animate_manual_resizes = "false";
        animate_mouse_windowdragging = "false";
        allow_session_lock_restore = "true";
        new_window_takes_over_fullscreen = "2";
        middle_click_paste = "false";
      };

      experimental.xx_color_management_v4 = "true";
    };
  };
}
