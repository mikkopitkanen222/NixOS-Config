# https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
{ ... }:
{
  security.pam.services.hyprlock.u2fAuth = true;

  home-manager.users.mp = {
    programs.hyprlock = {
      enable = true;
      settings = {
        "$font" = "Monospace";

        general = {
          grace = "5";
          immediate_render = "true";
        };

        animations = {
          bezier = [ "linear, 1, 1, 0, 0" ];
          animation = [
            "fade, 1, 2, linear"
            "inputField, 1, 2, linear"
          ];
        };

        background = {
          path = "screenshot";
          blur_passes = "3";
          vibrancy_darkness = "0.5";
        };

        input-field = {
          halign = "center";
          valign = "center";
          position = "0, -20";

          size = "20%, 5%";
          rounding = "15";
          fade_on_empty = "false";

          font_family = "$font";
          placeholder_text = "<i>Guess a number between 0x45 and 0x539</i>";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";

          dots_size = "0.45";
          dots_spacing = "0.2";
          dots_rounding = "5";

          font_color = "rgba(777777ee)";
          inner_color = "rgba(ddffffee)";
          outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";
        };

        label = [
          # Date
          {
            halign = "center";
            valign = "top";
            position = "0, -15";
            font_family = "$font";
            font_size = "25";
            text = "cmd[update:1000] date +\"%A, %d %B %Y\"";
          }
          # Time
          {
            halign = "center";
            valign = "top";
            position = "0, -55";
            font_family = "$font";
            font_size = "90";
            text = "$TIME";
          }
          # Keyboard layout
          {
            halign = "center";
            valign = "center";
            position = "250, -20";
            font_size = "18";
            text = "$LAYOUT[fi,en]";
            onclick = "hyprctl switchxkblayout all next";
          }
        ];
      };
    };
  };
}
