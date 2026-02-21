# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
{ lib, pkgs, ... }:
let
  settings = {
    # https://wiki.hypr.land/Configuring/Monitors/
    monitorv2 = [
      {
        output = "desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685";
        # Maximum refresh rate supporting both bitdepth=10 and HDR is 144 Hz:
        mode = "3440x1440@144";
        position = "0x0";
        scale = 1.0;
        bitdepth = 10;
        cm = "hdr";
        sdrbrightness = 1.3;
        sdrsaturation = 1.3;
      }
      {
        output = "desc:Acer Technologies Acer KG241 P 0x91305EF3";
        mode = "1920x1080@120";
        # Position on the left, rotated 90 degrees counter-clockwise:
        position = "-1080x-400";
        transform = 3;
        scale = 1.0;
      }
      # Default placement for extra monitors:
      {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1.0;
      }
    ];

    # https://wiki.hypr.land/Configuring/Variables/#input
    input = {
      kb_model = "pc105";
      kb_layout = "fi";
      kb_variant = "winkeys";
      numlock_by_default = true;
      scroll_method = "on_button_down";
      scroll_button = 274;
      scroll_factor = 0.8;
    };

    # https://wiki.hypr.land/Configuring/Variables/#general
    general = {
      border_size = 3;
      gaps_in = 0;
      gaps_out = 0;
      "col.inactive_border" = "rgba(2c2c2cec)";
      "col.active_border" = "rgba(541680f4) rgba(d0a028f4) 90deg";
      layout = "dwindle";
    };

    # https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
      rounding = 10;
      rounding_power = 2.0;
      shadow = {
        range = 12;
        render_power = 3;
        offset = "3 4";
        color = "rgba(00000034)";
      };
    };

    # https://wiki.hypr.land/Configuring/Variables/#animations
    animations = {
      workspace_wraparound = true;
      bezier = [
        "easeOutQuint,   0.23, 1.00, 0.32, 1.00"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1.00"
        "linear,         0.00, 0.00, 1.00, 1.00"
        "almostLinear,   0.50, 0.50, 0.75, 1.00"
        "quick,          0.15, 0.00, 0.10, 1.00"
      ];
      animation = [
        "global,        1, 10.0, default"
        "windows,       1, 4.80, easeOutQuint"
        "windowsIn,     1, 4.10, easeOutQuint,   popin 60%"
        "windowsOut,    1, 1.50, linear,         popin 70%"
        "layers,        1, 3.80, easeOutQuint"
        "layersIn,      1, 4.00, easeOutQuint,   fade"
        "layersOut,     1, 1.50, linear,         fade"
        "fade,          1, 3.05, quick"
        "fadeIn,        1, 1.75, almostLinear"
        "fadeOut,       1, 1.45, almostLinear"
        "fadeLayersIn,  1, 1.80, almostLinear"
        "fadeLayersOut, 1, 1.40, almostLinear"
        "border,        1, 5.40, easeOutQuint"
        "workspaces,    1, 1.95, almostLinear,   fade"
        "workspacesIn,  1, 2.00, easeInOutCubic, slidefade 30%"
        "workspacesOut, 1, 2.00, easeInOutCubic, slidefade 30%"
        "zoomFactor,    1, 7.00, quick"
      ];
    };

    # https://wiki.hypr.land/Configuring/Dwindle-Layout/
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    # https://wiki.hypr.land/Configuring/Scrolling-Layout/
    scrolling = {
      column_width = 0.49;
      follow_min_visible = 0.0;
    };

    # https://wiki.hypr.land/Configuring/Variables/#ecosystem
    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    # https://wiki.hypr.land/Configuring/Variables/#misc
    misc = {
      disable_splash_rendering = true;
      vrr = 3;
      disable_autoreload = true;
      middle_click_paste = false;
    };

    # https://wiki.hypr.land/Configuring/Permissions/
    ecosystem.enforce_permissions = true;
    permission = [
      # TODO: .quickshell-wrapped
      "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
      "${lib.getExe pkgs.xdg-desktop-portal-hyprland}, screencopy, allow"
    ];

    # https://wiki.hypr.land/Configuring/Binds/
    bind = [
      # Application Launchers
      "SUPER,            E, exec, kitty --class nnn -e 'nnn'"
      "SUPER,            N, exec, dms ipc call notepad toggle"
      "SUPER,            R, exec, dms ipc call spotlight toggle"
      "SUPER,            T, exec, uwsm app -- kitty"
      "SUPER,            V, exec, kitty --class clipse -e 'clipse'"
      "SUPER SHIFT,      V, exec, dms ipc call clipboard toggle"
      "SUPER,            X, exec, dms ipc call powermenu toggle"
      "SUPER,       Delete, exec, kitty --class btop -e 'btop'"
      "SUPER SHIFT, Delete, exec, dms ipc call processlist focusOrToggle"
      "SUPER,      Section, exec, uwsm app -- kitten quick-access-terminal"
      "SUPER,          Tab, exec, dms ipc call hypr toggleOverview"

      # Security
      "SUPER,            L, exec, dms ipc call lock lock"
      "SUPER SHIFT, Escape, exec, uwsm stop"

      # Window Management
      "SUPER,            C, killactive,"
      "SUPER SHIFT,      C, forcekillactive,"
      "SUPER,            F, togglefloating,"
      "SUPER SHIFT,      F, fullscreen, 0 toggle"
      "SUPER,            J, layoutmsg, togglesplit"
      "SUPER SHIFT,      J, layoutmsg, swapsplit"
      "SUPER,            P, pseudo,"
      "SUPER,        Comma, layoutmsg, focus l"
      "SUPER SHIFT,  Comma, layoutmsg, swapcol l"
      "SUPER,        Minus, layoutmsg, promote"
      "SUPER,       Period, layoutmsg, focus r"
      "SUPER SHIFT, Period, layoutmsg, swapcol r"

      # Focus Navigation
      "SUPER,  left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER,  down, movefocus, d"
      "SUPER,    up, movefocus, u"

      # Monitor Navigation
      "SUPER CTRL,  left, focusmonitor, l"
      "SUPER CTRL, right, focusmonitor, r"
      "SUPER CTRL,  down, focusmonitor, d"
      "SUPER CTRL,    up, focusmonitor, u"

      # Window Movement
      "SUPER SHIFT,  left, movewindow, l"
      "SUPER SHIFT, right, movewindow, r"
      "SUPER SHIFT,  down, movewindow, d"
      "SUPER SHIFT,    up, movewindow, u"

      # Move to Monitor
      "SUPER CTRL SHIFT,  left, movewindow, mon:l"
      "SUPER CTRL SHIFT, right, movewindow, mon:r"
      "SUPER CTRL SHIFT,  down, movewindow, mon:d"
      "SUPER CTRL SHIFT,    up, movewindow, mon:u"

      # Workspace Navigation
      "SUPER,          1, workspace, 1"
      "SUPER,          2, workspace, 2"
      "SUPER,          3, workspace, 3"
      "SUPER,          4, workspace, 4"
      "SUPER,          5, workspace, 5"
      "SUPER,          6, workspace, 6"
      "SUPER,          7, workspace, 7"
      "SUPER,          8, workspace, 8"
      "SUPER,          9, workspace, 9"
      "SUPER,          0, workspace, 10"
      "SUPER,          S, togglespecialworkspace, magic"
      "SUPER,        End, workspace, e+1"
      "SUPER,       Home, workspace, e-1"
      "SUPER, mouse_down, workspace, e+1"
      "SUPER,   mouse_up, workspace, e-1"

      # Move to Workspace
      "SUPER SHIFT,          1, movetoworkspace, 1"
      "SUPER SHIFT,          2, movetoworkspace, 2"
      "SUPER SHIFT,          3, movetoworkspace, 3"
      "SUPER SHIFT,          4, movetoworkspace, 4"
      "SUPER SHIFT,          5, movetoworkspace, 5"
      "SUPER SHIFT,          6, movetoworkspace, 6"
      "SUPER SHIFT,          7, movetoworkspace, 7"
      "SUPER SHIFT,          8, movetoworkspace, 8"
      "SUPER SHIFT,          9, movetoworkspace, 9"
      "SUPER SHIFT,          0, movetoworkspace, 10"
      "SUPER SHIFT,          S, movetoworkspace, special:magic"
      "SUPER SHIFT,        End, movetoworkspace, e+1"
      "SUPER SHIFT,       Home, movetoworkspace, e-1"
      "SUPER SHIFT, mouse_down, movetoworkspace, e+1"
      "SUPER SHIFT,   mouse_up, movetoworkspace, e-1"

      # Screenshots
      "SUPER,       F12, exec, dms screenshot"
      "SUPER CTRL,  F12, exec, dms screenshot window"
      "SUPER SHIFT, F12, exec, dms screenshot full"
    ];

    # Mouse binds:
    bindm = [
      # Move/resize windows with SUPER + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    # Will repeat when held; Works also when lock screen is active:
    bindel = [
      # Audio Controls
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 5"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 5"

      # Brightness Controls
      ",   XF86MonBrightnessUp, exec, dms ipc call brightness increment 5 \"\""
      ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5 \"\""
    ];

    # Works also when lock screen is active:
    bindl = [
      # Audio Controls
      ",    XF86AudioMute, exec, dms ipc call audio mute"
      ", XF86AudioMicMute, exec, dms ipc call audio micmute"

      # Media Controls
      ",  XF86AudioPlay, exec, dms ipc call mpris playPause"
      ", XF86AudioPause, exec, dms ipc call mpris playPause"
      ",  XF86AudioPrev, exec, dms ipc call mpris previous"
      ",  XF86AudioNext, exec, dms ipc call mpris next"
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
      "1, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true"
      "2, monitor:desc:Acer Technologies Acer KG241 P 0x91305EF3, persistent:true"
      "10, monitor:desc:ASUSTek COMPUTER INC VG34VQ3B SCLMTF073685, persistent:true, layout:scrolling"
    ];
  };
in
{
  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.uwsm.waylandCompositors.hyprland.binPath =
    lib.mkForce "/run/current-system/sw/bin/start-hyprland";

  home-manager.users.mp = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      inherit settings;
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
      hyprls
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
}
