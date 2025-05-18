# nixos-config/users/desknix-mp/waybar.nix
# Configure Waybar for user 'mp' on host 'desknix'.
# https://github.com/Alexays/Waybar
{ lib, pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.space-mono
      font-awesome
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          modules-left = [
            "hyprland/workspaces"
            "mpris"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "tray"
            "bluetooth"
            "pulseaudio"
            "network"
            "group/resources"
          ];

          "group/resources" = {
            orientation = "inherit";
            modules = [
              "temperature"
              "cpu"
              "memory"
            ];
            drawer = {
              transition-left-to-right = false;
              click-to-reveal = true;
            };
          };

          bluetooth = {
            format = " {status}";
            format-disabled = "󰂲!";
            format-off = "󰂲";
            format-on = "";
            format-connected = "󰂱";
            format-connected-battery = "󰂱 {device_battery_percentage}%";
            on-click = "overskride";
            tooltip-format = lib.strings.trim ''
              {controller_alias}
              {num_connections} connected
            '';
            tooltip-format-connected = lib.strings.trim ''
              {controller_alias}
              {num_connections} connected:
              {device_enumerate}
            '';
            tooltip-format-enumerate-connected = "{device_alias}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%";
          };

          clock = {
            interval = 1;
            format = "<tt> {:%H:%M:%S%n%Y-%m-%d}</tt>";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{:%V}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_down";
              on-scroll-down = "shift_up";
            };
          };

          cpu = {
            interval = 1;
            format = " {usage}%";
            states = {
              low = 0;
              mid = 25;
              high = 50;
              full = 75;
            };
          };

          memory = {
            interval = 1;
            format = " {percentage}%";
            states = {
              low = 0;
              mid = 25;
              high = 50;
              full = 75;
            };
            tooltip-format = "{used:0.1f}/{total:0.1f} GiB used";
          };

          mpris = {
            interval = 1;
            max-length = 48;
            format = "{player_icon} {status_icon} {title} - {artist}";
            format-stopped = "{player_icon} {status_icon}";
            tooltip-format = "{player} {status} \"{title}\" by {artist} [{position}/{length}]";
            tooltip-format-stopped = "{player} {status}";
            enable-tooltip-len-limits = true;
            player-icons = {
              default = "";
              brave = "󰖟";
              spotify_player = "";
            };
            status-icons = {
              playing = "";
              paused = "";
              stopped = "";
            };
          };

          network = {
            interval = 1;
            format-ethernet = "󰈀 {ifname}";
            format-wifi = "{icon} {signalStrength}%";
            format-linked = " {ifname}";
            format-disconnected = " internet";
            format-icons = [
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            on-click = "iwgtk";
            tooltip-format = "{ifname} {gwaddr}";
            tooltip-format-ethernet = lib.strings.trim ''
              {ipaddr}/{cidr} {ifname}
              {bandwidthDownBytes} down
              {bandwidthUpBytes} up
            '';
            tooltip-format-wifi = lib.strings.trim ''
              {essid} {frequency}
              {ipaddr}/{cidr} {ifname}
              {bandwidthDownBytes} down
              {bandwidthUpBytes} up
            '';
            tooltip-format-disconnected = "Disconnected";
          };

          pulseaudio = {
            format = "{icon} {volume}% {format_source}";
            format-muted = "{icon}  {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              headphone-muted = "󰟎";
              hands-free = "󰋎";
              hands-free-muted = "󰋐";
              headset = "󰋎";
              headset-muted = "󰋐";
              phone = "";
              phone-muted = "";
              portable = "";
              portable-muted = "";
              car = "";
              car-muted = "󰸜";
              default = [
                ""
                ""
                ""
              ];
              default-muted = "";
            };
            states = {
              full = 100;
              high = 85;
              mid = 70;
              low = 55;
            };
          };

          temperature = {
            hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
            critical-threshold = 85;
            interval = 1;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              "󰔄"
            ];
          };

          tray = {
            icon-size = 30;
            show-passive-items = false;
            spacing = 10;
            reverse-direction = true;
          };

          "hyprland/workspaces" = {
            all-outputs = true;
            format = "<sub>{icon}</sub>\n{windows}";
            # Use `hyprctl clients` to see classes and titles of open windows.
            # https://www.nerdfonts.com/cheat-sheet for glyphs.
            window-rewrite = {
              "class<brave-browser>" = "󰖟";
              "title<.*spotify.*>" = "";
              "title<.*twitch.*>" = "";
              "title<.*youtube.*>" = "";
              "class<codium>" = "󰨞";
              "class<kitty>" = "";
              "class<obsidian>" = "";
              "class<.*Qalculate.*>" = "";
              "class<steam>" = "";
              "class<thunderbird>" = "";
              "class<vesktop>" = "";
              "class<.*whatsie.*>" = "";
            };
            window-rewrite-default = "";
            format-window-separator = " ";
          };
        };
      };

      style = ''
        /*********************
         * Predefined colors *
         *********************/

        /*
         * Module and tooltip colors
         *
         * Tooltips use same colors as normal modules. Modules which have states
         * based on percentage values, etc., use the "Severity colors" below.
         */
        @define-color module_color #D0A028;
        @define-color module_border #54157E;
        @define-color module_background #0A0310;
        @define-color module_hover_color @module_color;
        @define-color module_hover_border @module_border;
        @define-color module_hover_background #1E0930;

        /*
         * Severity colors [low, mid, high, full]
         *
         * Most modules treat "low" as best and "full" as worst (e.g. cpu, audio),
         * but some modules reverse this order (e.g. battery).
         */
        @define-color severity1_color #00FF00;
        @define-color severity1_border #004000;
        @define-color severity1_background #000800;
        @define-color severity1_hover_color @severity1_color;
        @define-color severity1_hover_border @severity1_border;
        @define-color severity1_hover_background #001800;

        @define-color severity2_color #FFFF00;
        @define-color severity2_border #404000;
        @define-color severity2_background #080800;
        @define-color severity2_hover_color @severity2_color;
        @define-color severity2_hover_border @severity2_border;
        @define-color severity2_hover_background #181800;

        @define-color severity3_color #FF8000;
        @define-color severity3_border #402000;
        @define-color severity3_background #080400;
        @define-color severity3_hover_color @severity3_color;
        @define-color severity3_hover_border @severity3_border;
        @define-color severity3_hover_background #180C00;

        @define-color severity4_color #FF0000;
        @define-color severity4_border #400000;
        @define-color severity4_background #080000;
        @define-color severity4_hover_color @severity4_color;
        @define-color severity4_hover_border @severity4_border;
        @define-color severity4_hover_background #180000;

        /*
         * Workspace button colors
         *
         * Inactive workspace buttons use default module colors.
         */
        @define-color button_active_color #60D060;
        @define-color button_active_background #140620;
        @define-color button_active_hover_color @button_active_color;

        /**********
         * Styles *
         **********/

        * {
          font-family: "Hack Nerd Font", "SpaceMono Nerd Font", "Font Awesome 6 Free";
          font-size: 15px;
          border-radius: 15px;
          transition: background-color 0.3s ease-out;
        }

        window#waybar {
          background: transparent;
        }

        .modules-left,
        .modules-center,
        .modules-right {
          margin: 3px 0;
        }

        tooltip {
          background: @module_background;
          opacity: 0.9;
          border: 2px solid @module_border;
        }
        tooltip label {
          color: @module_color;
        }

        #bluetooth,
        #clock,
        #cpu,
        #memory,
        #mpris,
        #network,
        #pulseaudio,
        #temperature,
        #tray,
        #workspaces {
          color: @module_color;
          background: @module_background;
          opacity: 0.7;
          border: 2px solid @module_border;
          padding: 2px 10px 1px;
          margin: 0 3px;
        }
        #bluetooth:hover,
        #clock:hover,
        #cpu:hover,
        #memory:hover,
        #mpris:hover,
        #network:hover,
        #pulseaudio:hover,
        #temperature:hover,
        #tray:hover {
          color: @module_hover_color;
          background: @module_hover_background;
          border: 2px solid @module_hover_border;
        }

        #tray menu {
          color: @module_color;
          background: @module_background;
          opacity: 0.9;
          border: 2px solid @module_border;
        }
        #tray menuitem:hover {
          color: @module_color;
          background: @module_border;
          border-radius: 12px;
        }

        #workspaces {
          padding: 0;
        }
        #workspaces button {
          color: @module_color;
          border-radius: 12px;
          padding: 2px 13px 1px 10px;
        }
        #workspaces button.active {
          color: @button_active_color;
          background: @button_active_background;
        }
        #workspaces button:hover {
          color: @module_hover_color;
          background: @module_hover_background;
          border: 1px solid @module_border;
          box-shadow: inherit;
          text-shadow: inherit;
        }
        #workspaces button.active:hover {
          color: @button_active_hover_color;
        }

        /*
         * Severity 1 styles
         */
        #cpu.low,
        #memory.low,
        #network.ethernet,
        #network.wifi,
        #pulseaudio.low,
        #temperature {
          color: @severity1_color;
          background: @severity1_background;
          border: 2px solid @severity1_border;
        }

        /*
         * Severity 1 hover styles
         */
        #cpu.low:hover,
        #memory.low:hover,
        #network.ethernet:hover,
        #network.wifi:hover,
        #pulseaudio.low:hover,
        #temperature:hover {
          color: @severity1_hover_color;
          background: @severity1_hover_background;
          border: 2px solid @severity1_hover_border;
        }

        /*
         * Severity 2 styles
         */
        #cpu.mid,
        #memory.mid,
        #network.disconnected,
        #pulseaudio.mid {
          color: @severity2_color;
          background: @severity2_background;
          border: 2px solid @severity2_border;
        }

        /*
         * Severity 2 hover styles
         */
        #cpu.mid:hover,
        #memory.mid:hover,
        #network.disconnected:hover,
        #pulseaudio.mid:hover {
          color: @severity2_hover_color;
          background: @severity2_hover_background;
          border: 2px solid @severity2_hover_border;
        }

        /*
         * Severity 3 styles
         */
        #cpu.high,
        #memory.high,
        #network.disabled,
        #pulseaudio.high {
          color: @severity3_color;
          background: @severity3_background;
          border: 2px solid @severity3_border;
        }

        /*
         * Severity 3 hover styles
         */
        #cpu.high:hover,
        #memory.high:hover,
        #network.disabled:hover,
        #pulseaudio.high:hover {
          color: @severity3_hover_color;
          background: @severity3_hover_background;
          border: 2px solid @severity3_hover_border;
        }

        /*
         * Severity 4 styles
         */
        #cpu.full,
        #memory.full,
        #network.linked,
        #pulseaudio.full,
        #temperature.critical {
          color: @severity4_color;
          background: @severity4_background;
          border: 2px solid @severity4_border;
        }

        /*
         * Severity 4 hover styles
         */
        #cpu.full:hover,
        #memory.full:hover,
        #network.linked:hover,
        #pulseaudio.full:hover,
        #temperature.critical:hover {
          color: @severity4_hover_color;
          background: @severity4_hover_background;
          border: 2px solid @severity4_hover_border;
        }
      '';
    };

    # Waybar network module is more featureful; iwgtk -i is not needed.
    xdg.configFile."autostart/iwgtk-indicator.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
  };
}
