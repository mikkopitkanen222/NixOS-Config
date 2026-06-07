# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.hyprland;

  inherit (lib.types)
    nullOr
    oneOf
    bool
    int
    float
    str
    path
    attrsOf
    listOf
    ;

  # settingValueType = nullOr (oneOf [
  #   bool
  #   int
  #   float
  #   str
  #   path
  #   (attrsOf settingValueType)
  #   (listOf settingValueType)
  # ]);

  monitorType = attrsOf (oneOf [
    bool
    int
    float
    str
    path
    (attrsOf int)
  ]);

  toString' =
    value:
    if (builtins.isBool value) then
      lib.boolToString value
    else if ((builtins.isInt value) || (builtins.isFloat value)) then
      lib.toString value
    else if (builtins.isAttrs value) then
      attrsToLua value
    else
      ''"${value}"'';

  attrsToLua =
    attrs:
    "{ ${
      lib.strings.concatStringsSep ", " (
        lib.attrsets.mapAttrsToList (name: value: "${name} = ${toString' value}") attrs
      )
    } }";

  hyprConfigFiles = {
    main = ''
      function requireOptional(moduleName)
        local status, value = pcall(require, moduleName)
        if status then
          print("Successfully loaded module '", moduleName, "'")
        else
          print("Failed to load module '", moduleName, "': ", value)
        end
      end

      require("config")
      require("monitors")
      require("decoration")
      require("binds")
      require("animations")
      require("input")
    '';

    config = ''
      hl.config({
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
        general = {
          border_size = 3,
          gaps_in = 0,
          gaps_out = 0,
          float_gaps = 0,
          gaps_workspaces = 0,
          col.inactive_border = "#2c2c2cec",
          col.active_border = { colors = { "#541680f4", "#d0a028f4" }, angle = 90 },
          col.nogroup_border = "#ffaaffff",
          col.nogroup_border_active = "#ff00ffff",
          layout = "dwindle",
          no_focus_fallback = false,
          resize_on_border = false,
          extend_border_grab_area = 15,
          hover_icon_on_border = true,
          allow_tearing = false,
          resize_corner = 0,
          modal_parent_blocking = true,
          -- locale = "",

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#snap
          snap = {
            enabled = false,
            window_gap = 10,
            monitor_gap = 10,
            border_overlap = true,
            respect_gaps = false,
          },
        },

        -- Decorations are set in decoration.lua
        -- Animations are set in animations.lua
        -- Inputs are set in input.lua
        -- Gestures are set in input.lua

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#group
        group = {
          auto_group = true,
          insert_after_current = false,
          focus_removed_window = true,
          drag_into_group = 1,
          merge_groups_on_drag = true,
          merge_groups_on_groupbar = true,
          merge_floated_into_tiled_on_groupbar = false,
          group_on_movetoworkspace = false,
          col.border_active = "#ffff0066",
          col.border_inactive = "#77770066",
          col.border_locked_active = "#ff550066",
          col.border_locked_inactive = "#77550066",

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#groupbar
          groupbar = {
            enabled = true,
            -- font_family = "",
            font_size = 8,
            font_weight_active = "normal",
            font_weight_inactive = "normal",
            gradients = true,
            height = 14,
            indicator_gap = 0,
            indicator_height = 3,
            stacked = false,
            priority = 3,
            render_titles = true,
            text_offset = 0,
            text_padding = 0,
            scrolling = true,
            rounding = 1,
            rounding_power = 2.0,
            gradient_rounding = 2,
            gradient_rounding_power = 2.0,
            round_only_edges = true,
            gradient_round_only_edges = true,
            text_color = "#ffffffff",
            text_color_inactive = "#ffffffff",
            text_color_locked_active = "#ffffffff",
            text_color_locked_inactive = "#ffffffff",
            col.active = "#ffff0066",
            col.inactive = "#77770066",
            col.locked_active = "#ff550066",
            col.locked_inactive = "#77550066",
            gaps_in = 2,
            gaps_out = 2,
            keep_upper_gap = true,
            middle_click_close = true,
            blur = false,
          },
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
        misc = {
          disable_hyprland_logo = false,
          disable_splash_rendering = true,
          disable_scale_notification = false,
          col.splash = "#ffffffff",
          font_family = "Sans",
          -- splash_font_family = "",
          force_default_wallpaper = -1,
          vrr = 3,
          mouse_move_enables_dpms = false,
          key_press_enables_dpms = false,
          name_vk_after_proc = true,
          always_follow_on_dnd = true,
          layers_hog_keyboard_focus = true,
          animate_manual_resizes = false,
          animate_mouse_windowdragging = false,
          disable_autoreload = true,
          enable_swallow = false,
          -- swallow_regex = "",
          -- swallow_exception_regex = "",
          focus_on_activate = false,
          mouse_move_focuses_monitor = true,
          allow_session_lock_restore = false,
          session_lock_xray = false,
          background_color = "#111111",
          close_special_on_empty = true,
          on_focus_under_fullscreen = 2,
          exit_window_retains_fullscreen = false,
          initial_workspace_tracking = 1,
          middle_click_paste = false,
          render_unfocused_fps = 15,
          disable_xdg_env_checks = false,
          disable_hyprland_qtutils_check = false,
          lockdead_screen_delay = 1000,
          enable_anr_dialog = true,
          anr_missed_pings = 5,
          size_limits_tiled = false,
          disable_watchdog_warning = false,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
        layout = {
          single_window_aspect_ratio = { 0, 0 },
          single_window_aspect_ratio_tolerance = 0.1,
        },

        -- Binds are set in binds.lua

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#xwayland
        xwayland = {
          enabled = true,
          use_nearest_neighbor = true,
          force_zero_scaling = false,
          create_abstract_socket = false,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#opengl
        opengl = {
          nvidia_anti_flicker = true,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#render
        render = {
          direct_scanout = 2,
          expand_undersized_textures = true,
          xp_mode = false,
          ctm_animation = 2,
          cm_enabled = true,
          send_content_type = true,
          cm_auto_hdr = 1,
          new_render_scheduling = true,
          non_shader_cm = 2,
          non_shader_cm_interop = 2,
          cm_sdr_eotf = "default",
          commit_timing_enabled = true,
          use_fp16 = 2,
          keep_unmodified_copy = 2,
          use_shader_blur_blend = false,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#cursor
        cursor = {
          invisible = false,
          sync_gsettings_theme = true,
          no_hardware_cursors = 2,
          no_break_fs_vrr = 2,
          min_refresh_rate = 60,
          hotspot_padding = 1,
          inactive_timeout = 0.0,
          no_warps = false,
          persistent_warps = true,
          warp_on_change_workspace = 1,
          warp_on_toggle_special = 1,
          -- default_monitor = "",  -- Might be set in monitors.lua
          zoom_factor = 1.0,
          zoom_rigid = false,
          zoom_detached_camera = true,
          enable_hyprcursor = true,
          hide_on_key_press = false,
          hide_on_touch = true,
          hide_on_tablet = true,
          use_cpu_buffer = 2,
          warp_back_after_non_mouse_input = false,
          zoom_disable_aa = false,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#ecosystem
        ecosystem = {
          no_update_news = true,
          no_donation_nag = true,
          enforce_permissions = true,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#quirks
        quirks = {
          prefer_hdr = 2,
        },
      })
    '';

    monitors = lib.strings.concatStringsSep "\n" [
      (lib.strings.optionalString (cfg.monitors.cursorDefaultMonitor != null) ''
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#cursor
        hl.config({ cursor.default_monitor = "${cfg.monitors.cursorDefaultMonitor}" })
      '')
      ''
        -- https://wiki.hypr.land/Configuring/Basics/Monitors/
        ${lib.strings.concatStringsSep "\n" (
          map (monitor: "hl.monitor(${attrsToLua monitor})") cfg.monitors.monitors
        )}
      ''
      (lib.strings.optionalString cfg.monitors.addDefaultPlacement ''
        -- Default placement for extra monitors:
        hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.0 })
      '')
    ];

    decoration = ''
      hl.config({
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
        decoration = {
          rounding = 10,
          rounding_power = 2.0,
          active_opacity = 1.0,
          inactive_opacity = 1.0,
          fullscreen_opacity = 1.0,
          dim_modal = true,
          dim_inactive = false,
          dim_strength = 0.5,
          dim_special = 0.2,
          dim_around = 0.4,
          -- screen_shader = "",
          border_part_of_window = true,

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
          blur = {
            enabled = ${lib.boolToString (!cfg.savePower)},
            size = 8,
            passes = 1,
            ignore_opacity = true,
            new_optimizations = true,
            xray = true,
            noise = 0.0117,
            contrast = 0.8916,
            brightness = 0.8172,
            vibrancy = 0.1696,
            vibrancy_darkness = 0.0,
            special = false,
            popups = false, -- TODO: Try it!
            popups_ignorealpha = 0.2,
            input_methods = false,
            input_methods_ignorealpha = 0.2,
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
          shadow = {
            enabled = ${lib.boolToString (!cfg.savePower)},
            range = 12,
            render_power = 3,
            sharp = false,
            color = "#00000034",
            color_inactive = "#00000034",
            offset = { 3, 4 },
            scale = 1.0,
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#glow
          glow = {
            enabled = false,
            range = 12,
            render_power = 3,
            color = "#1a1a1a34",
            color_inactive = "#00000000",
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#motion-blur
          motion_blur = {
            enabled = false,
            samples = 7,
          },
        },
      })
    '';

    binds = ''
      hl.config({
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#binds
        binds = {
          pass_mouse_when_bound = false,
          scroll_event_delay = 300,
          workspace_back_and_forth = false,  -- TODO: Try it!
          hide_special_on_workspace_change = true,
          allow_workspace_cycles = false,
          workspace_center_on = 1,
          focus_preferred_method = 0,
          ignore_group_lock = false,
          movefocus_cycles_fullscreen = false,
          movefocus_cycles_groupfirst = false,  -- TODO: Try it!
          window_direction_monitor_fallback = true,
          disable_keybind_grabbing = false,
          allow_pin_fullscreen = false,
          drag_threshold = 0,
        },
      })

      -- https://wiki.hypr.land/Configuring/Basics/Binds/
      -- https://wiki.hypr.land/Configuring/Basics/Dispatchers/

      -- Application Launchers:
      hl.bind("SUPER + E", hl.dsp.exec_cmd("kitty --class nnn -e 'nnn'"), { description = "Open nnn TUI file manager" })
      hl.bind("SUPER + L", hl.dsp.exec_cmd("dms ipc call lock lock"), { description = "Lock the screen" })
      hl.bind("SUPER + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"), { description = "Toggle DMS notepad overlay" })
      hl.bind("SUPER + R", hl.dsp.exec_cmd("dms ipc call spotlight toggle"), { description = "Toggle DMS application launcher" })
      hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm app -- kitty"), { description = "Open kitty terminal emulator" })
      hl.bind("SUPER + V", hl.dsp.exec_cmd("kitty --class clipse -e 'clipse'"), { description = "Open clipse TUI clipboard manager" })
      hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"), { description = "Toggle DMS clipboard manager overlay" })
      hl.bind("SUPER + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"), { description = "Toggle DMS power menu overlay" })
      hl.bind("SUPER + Delete", hl.dsp.exec_cmd("kitty --class btop -e 'btop'"), { description = "Open btop TUI resource manager" })
      hl.bind("SUPER + SHIFT + Delete", hl.dsp.exec_cmd("kitty --class dgop -e 'dgop'"), { description = "Open DMS dgop resource manager " })
      hl.bind("SUPER + SHIFT + Escape", hl.dsp.exec_cmd("uwsm stop"), { description = "Terminate the login session" })
      hl.bind("SUPER + Section", hl.dsp.exec_cmd("uwsm app -- kitten quick-access-terminal"), { description = "Toggle kitty quick access terminal overlay" })
      hl.bind("SUPER + Tab", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"), { description = "Toggle DMS overview overlay" })

      -- Window Management:
      hl.bind("SUPER + C", hl.dsp.window.close("activewindow"), { description = "Kindly ask the active window to close" })
      hl.bind("SUPER + SHIFT + C", hl.dsp.window.kill("activewindow"), { description = "Tell the active window's owner process to go fuck itself" })
      hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle", window = "activewindow" }), { description = "Toggle active window floating state" })
      hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle", window = "activewindow" }), { description = "Toggle active window fullscreen state" })
      hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { description = "Dwindle: Toggle active window split axis" })
      hl.bind("SUPER + SHIFT + J", hl.dsp.layout("swapsplit"), { description = "Dwindle: Swap active window with window on the other side of the split" })
      hl.bind("SUPER + P", hl.dsp.window.pseudo("active"), { description = "Dwindle: Toggle active window pseudotiling" })
      hl.bind("SUPER + Comma", hl.dsp.layout("focus l"), { description = "Scrolling: Move focus left" })
      hl.bind("SUPER + SHIFT + Comma", hl.dsp.layout("swapcol l"), { description = "Scrolling: Move active column left" })
      hl.bind("SUPER + Minus", hl.dsp.layout("promote"), { description = "Scrolling: Promote active window to its own column" })
      hl.bind("SUPER + Period", hl.dsp.layout("focus r"), { description = "Scrolling: Move focus right" })
      hl.bind("SUPER + SHIFT + Period", hl.dsp.layout("swapcol r"), { description = "Scrolling: Move active column right" })

      -- Switch Active Window:
      hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
      hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
      hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })
      hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })

      -- Switch Active Monitor:
      hl.bind("SUPER + CTRL + left", hl.dsp.focus({ monitor = "l" }), { description = "Move focus left to another monitor" })
      hl.bind("SUPER + CTRL + right", hl.dsp.focus({ monitor = "r" }), { description = "Move focus right to another monitor" })
      hl.bind("SUPER + CTRL + down", hl.dsp.focus({ monitor = "d" }), { description = "Move focus down to another monitor" })
      hl.bind("SUPER + CTRL + up", hl.dsp.focus({ monitor = "u" }), { description = "Move focus up to another monitor" })

      -- Move Window:     TODO: Test group_aware = true
      hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l", group_aware = false, window = "activewindow" }), { description = "Move active window left" })
      hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r", group_aware = false, window = "activewindow" }), { description = "Move active window right" })
      hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d", group_aware = false, window = "activewindow" }), { description = "Move active window down" })
      hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u", group_aware = false, window = "activewindow" }), { description = "Move active window up" })

      -- Move Window to Monitor:
      hl.bind("SUPER + CTRL + SHIFT + left", hl.dsp.window.move({ monitor = "l", follow = true, window = "activewindow" }), { description = "Move active window left to another monitor" })
      hl.bind("SUPER + CTRL + SHIFT + right", hl.dsp.window.move({ monitor = "r", follow = true, window = "activewindow" }), { description = "Move active window right to another monitor" })
      hl.bind("SUPER + CTRL + SHIFT + down", hl.dsp.window.move({ monitor = "d", follow = true, window = "activewindow" }), { description = "Move active window down to another monitor" })
      hl.bind("SUPER + CTRL + SHIFT + up", hl.dsp.window.move({ monitor = "u", follow = true, window = "activewindow" }), { description = "Move active window up to another monitor" })

      -- Switch Active Workspace:
      hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1, on_current_monitor = false }), { description = "Focus workspace 1" })
      hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2, on_current_monitor = false }), { description = "Focus workspace 2" })
      hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3, on_current_monitor = false }), { description = "Focus workspace 3" })
      hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4, on_current_monitor = false }), { description = "Focus workspace 4" })
      hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5, on_current_monitor = false }), { description = "Focus workspace 5" })
      hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6, on_current_monitor = false }), { description = "Focus workspace 6" })
      hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7, on_current_monitor = false }), { description = "Focus workspace 7" })
      hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8, on_current_monitor = false }), { description = "Focus workspace 8" })
      hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9, on_current_monitor = false }), { description = "Focus workspace 9" })
      hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10, on_current_monitor = false }), { description = "Focus workspace 10" })
      hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle workspace special:magic" })
      hl.bind("SUPER + End", hl.dsp.focus({ workspace = "e+1", on_current_monitor = false }), { description = "Focus next workspace" })
      hl.bind("SUPER + Home", hl.dsp.focus({ workspace = "e-1", on_current_monitor = false }), { description = "Focus previous workspace" })
      hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1", on_current_monitor = false }), { description = "Focus next workspace" })
      hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1", on_current_monitor = false }), { description = "Focus previous workspace" })

      -- Move Window to Workspace:
      hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = true, window = "activewindow" }), { description = "Move window to workspace 1" })
      hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = true, window = "activewindow" }), { description = "Move window to workspace 2" })
      hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = true, window = "activewindow" }), { description = "Move window to workspace 3" })
      hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = true, window = "activewindow" }), { description = "Move window to workspace 4" })
      hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = true, window = "activewindow" }), { description = "Move window to workspace 5" })
      hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = true, window = "activewindow" }), { description = "Move window to workspace 6" })
      hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = true, window = "activewindow" }), { description = "Move window to workspace 7" })
      hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = true, window = "activewindow" }), { description = "Move window to workspace 8" })
      hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = true, window = "activewindow" }), { description = "Move window to workspace 9" })
      hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = true, window = "activewindow" }), { description = "Move window to workspace 10" })
      hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true, window = "activewindow" }), { description = "Move window to workspace special:magic" })
      hl.bind("SUPER + SHIFT + End", hl.dsp.window.move({ workspace = "e+1", follow = true, window = "activewindow" }), { description = "Move window to next workspace" })
      hl.bind("SUPER + SHIFT + Home", hl.dsp.window.move({ workspace = "e-1", follow = true, window = "activewindow" }), { description = "Move window to previous workspace" })
      hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "e+1", follow = true, window = "activewindow" }), { description = "Move window to next workspace" })
      hl.bind("SUPER + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "e-1", follow = true, window = "activewindow" }), { description = "Move window to previous workspace" })

      -- Screenshots:
      hl.bind("SUPER + F12", hl.dsp.exec_cmd("dms screenshot"), { description = "Screenshot selected area" })
      hl.bind("SUPER + CTRL + F12", hl.dsp.exec_cmd("dms screenshot window"), { description = "Screenshot active window" })
      hl.bind("SUPER + SHIFT + F12", hl.dsp.exec_cmd("dms screenshot full"), { description = "Screenshot whole monitor" })

      -- Mouse Binds:
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { description = "Drag windows with SUPER + LMB and dragging" })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { description = "Resize windows with SUPER + RMB and dragging" })

      -- Media & Brightness Controls:
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { description = "Increase audio volume", locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { description = "Decrease audio volume", locked = true, repeating = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { description = "Mute audio output", locked = true })
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { description = "Mute audio input", locked = true })
      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { description = "Play / pause media playback", locked = true })
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { description = "Play / pause media playback", locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { description = "Skip to previous track", locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { description = "Skip to next track", locked = true })
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("dms ipc call brightness increment 5 \"\""), { description = "Increase monitor brightness", locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("dms ipc call brightness decrement 5 \"\""), { description = "Decrease monitor brightness", locked = true, repeating = true })
    '';

    animations = ''
      hl.config({
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
        animations = {
          enabled = true,
          workspace_wraparound = true,
        },
      })

      -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#curves
      hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1.00 }, { 0.32, 1.00 } } })
      hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1.00 } } })
      hl.curve("linear",         { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1.00 } } })
      hl.curve("almostLinear",   { type = "bezier", points = { { 0.50, 0.50 }, { 0.75, 1.00 } } })
      hl.curve("quick",          { type = "bezier", points = { { 0.15, 0.00 }, { 0.10, 1.00 } } })

      -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#general
      hl.animation({ leaf = "global",        enabled = true, speed = 10.0, bezier = "default" })
      hl.animation({ leaf = "windows",       enabled = true, speed = 4.80, bezier = "easeOutQuint" })
      hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.10, bezier = "easeOutQuint",   style = "popin 60%" })
      hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.50, bezier = "linear",         style = "popin 70%" })
      hl.animation({ leaf = "layers",        enabled = true, speed = 3.80, bezier = "easeOutQuint" })
      hl.animation({ leaf = "layersIn",      enabled = true, speed = 4.00, bezier = "easeOutQuint",   style = "fade" })
      hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.50, bezier = "linear",         style = "fade" })
      hl.animation({ leaf = "fade",          enabled = true, speed = 3.05, bezier = "quick" })
      hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.75, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.45, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.80, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.40, bezier = "almostLinear" })
      hl.animation({ leaf = "border",        enabled = true, speed = 5.40, bezier = "easeOutQuint" })
      hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.95, bezier = "almostLinear",   style = "fade" })
      hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.00, bezier = "easeInOutCubic", style = "slidefade 30%" })
      hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.00, bezier = "easeInOutCubic", style = "slidefade 30%" })
      hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7.00, bezier = "quick" })
    '';

    input = ''
      hl.config({
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#input
        input = {
          kb_model = "pc105",
          kb_layout = "fi",
          kb_variant = "winkeys",
          -- kb_options = "",
          -- kb_rules = "",
          -- kb_file = "",
          numlock_by_default = true,
          resolve_binds_by_sym = false,
          repeat_rate = 25,
          repeat_delay = 500,
          sensitivity = 0.0,
          accel_profile = "flat",
          force_no_accel = false,
          rotation = 0,
          left_handed = false,
          -- scroll_points = "",
          scroll_method = "on_button_down",
          scroll_button = 274,
          scroll_button_lock = true,
          scroll_factor = 1.0,
          natural_scroll = false,
          follow_mouse = 1,
          follow_mouse_shrink = 0,
          follow_mouse_threshold = 0.0,
          focus_on_close = 1,
          mouse_refocus = true,
          float_switch_override_focus = 1,
          special_fallthrough = false,
          off_window_axis_events = 1
          emulate_discrete_scroll = 1,

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
          touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            scroll_factor = 1.0,
            middle_button_emulation = false,
            tap_button_map = "lrm",
            clickfinger_behavior = false,
            tap_to_click = true,
            drag_lock = 1,
            tap_and_drag = true,
            flip_x = false,
            flip_y = false,
            drag_3fg = 0,
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#touchdevice
          touchdevice = {
            transform = 0,
            -- output = "",
            enabled = true,
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#virtualkeyboard
          virtualkeyboard = {
            share_states = 2,
            release_pressed_on_close = false,
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#tablet
          tablet = {
            transform = 0,
            -- output = "",
            region_position = { 0, 0 },
            absolute_region_position = false,
            region_size = { 0, 0 },
            relative_input = false,
            left_handed = false,
            active_area_size = { 0, 0 },
            active_area_position = { 0, 0 },
          },

          -- https://wiki.hypr.land/Configuring/Basics/Variables/#tablettool
          tablettool = {
            eraser_button_mode = 0,
            eraser_button_override = 0,
            pressure_range_min = -1.0,
            pressure_range_max = -1.0,
          },
        },

        https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
        gestures = {
          workspace_swipe_distance = 300,
          workspace_swipe_touch = false,
          workspace_swipe_invert = true,
          workspace_swipe_touch_invert = false,
          workspace_swipe_min_speed_to_force = 30,
          workspace_swipe_cancel_ratio = 0.5,
          workspace_swipe_create_new = true,
          workspace_swipe_direction_lock = true,
          workspace_swipe_direction_lock_threshold = 10,
          workspace_swipe_forever = false,
          workspace_swipe_use_r = false,
          close_max_timeout = 1000,
        },
      })
    '';
  };

  settings = lib.mkMerge [
    {
      # config was here

      # TODO: Put these to config:
      # https://wiki.hypr.land/Configuring/Dwindle-Layout/
      dwindle = {
        preserve_split = true;
      };
      # https://wiki.hypr.land/Configuring/Scrolling-Layout/
      scrolling = {
        column_width = 0.49;
        follow_min_visible = 0.0;
      };

      permission = [
        # TODO: .quickshell-wrapped
        "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
        "${lib.getExe config.programs.hyprland.portalPackage}, screencopy, allow"
      ];

      # https://wiki.hypr.land/Configuring/Window-Rules/
      windowrule = [
        {
          name = "suppress-maximize-events";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;
          no_focus = true;
        }
      ];

      # https://wiki.hypr.land/Configuring/Workspace-Rules/
      workspace = [
        "1, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true, default:true"
        "2, monitor:desc:Acer Technologies Acer KG241 P 0x91305EF3, persistent:true, default:true"
        "10, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true, layout:scrolling"
      ];
    }
  ];
in
{
  options.mp222.hyprland = {
    monitors = {
      monitors = lib.mkOption {
        type = listOf monitorType;
        default = [ ];
        description = "List of attribute sets describing Hyprland monitors.";
        example = ''
          [ { output = "DP-1", mode = "1920x1080@144", position = "0x0", scale = 1.0 } ]
        '';
      };

      addDefaultPlacement = lib.mkOption {
        type = bool;
        default = true;
        description = "Add default placement for extra monitors.";
        example = false;
      };

      cursorDefaultMonitor = lib.mkOption {
        type = nullOr str;
        default = null;
        description = ''
          The name of a default monitor for the cursor to be set to on startup.
          Leave `null` to let Hyprland decide (will probably use the first monitor in `monitors`).
          TODO: Need to test if this works with output name, description, or either.
        '';
        example = "DP-1";
      };
    };

    savePower = lib.mkOption {
      type = bool;
      default = false;
      description = ''
        Turn off eye candy to save power on laptops. See
        https://wiki.hypr.land/Configuring/Performance/#how-do-i-make-hyprland-draw-as-little-power-as-possible-on-my-laptop
      '';
      example = true;
    };
  };

  config = {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    programs.hyprland =
      let
        hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        package = hyprPkgs.hyprland;
        portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
        withUWSM = true;
      };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    hardware.graphics =
      let
        hyprNixpkgs =
          inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        package = hyprNixpkgs.mesa;
        package32 = hyprNixpkgs.pkgsi686Linux.mesa;
      };

    home-manager.users.mp = {
      # Generate all config files in ´$XDG_CONFIG_HOME/hypr/mp222/´:
      xdg.configFile = builtins.listToAttrs (
        map (filename: {
          name = "hypr/mp222/${filename}.lua";
          value.text = hyprConfigFiles.${filename};
        }) (builtins.attrNames hyprConfigFiles)
      );

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = !config.programs.hyprland.withUWSM;
        configType = "lua";
        # ´$XDG_CONFIG_HOME/hypr/hyprland.lua´ generated by Home-Manager only
        # imports the self-generated ´$XDG_CONFIG_HOME/hypr/mp222/main.lua´,
        # which contains additional imports with all Hyprland configuration:
        extraConfig = "require(\"mp222/main\")";
        # Use the packages from the NixOS module:
        package = null;
        portalPackage = null;
      };
      home.sessionVariables.NIXOS_OZONE_WL = "1";

      home.pointerCursor = {
        hyprcursor.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };

      home.packages = with pkgs; [
        hyprpicker
        hyprsysteminfo
        xdg-desktop-portal-gtk
      ];

      services.hyprpolkitagent.enable = true;

      programs.zsh.profileExtra = lib.mkAfter ''
        if [[ "$(tty)" = "/dev/tty1" ]] && uwsm check may-start; then
          exec uwsm start -eD Hyprland hyprland-uwsm.desktop
        fi
      '';
    };
  };
}
