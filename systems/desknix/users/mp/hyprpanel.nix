# https://github.com/Jas-SinghFSU/HyprPanel
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Reference colors taken from my Hyprland window borders:
  # orangey yellow: d0a028e0,  purple: 54157ee0
  primary1Color = "#c69826"; # [Reference yellow] * 0.95
  primary2Color = "#ebb52d"; # [Reference yellow] * 1.13
  secondary1Color = "#501478"; # [Reference purple] * 0.95
  secondary2Color = "#5e188e"; # [Reference purple] * 1.13
  background1Color = "#000000";
  background2Color = "#101010";
  passiveColor = "#484848";

  customTheme = {
    bar = {
      transparent = true;
      buttons = {
        monochrome = true;
        background = background2Color;
        borderColor = secondary1Color;
        icon = primary2Color;
        text = primary1Color;
        workspaces = {
          active = primary1Color;
          available = secondary1Color;
          background = background2Color;
          border = secondary1Color;
          hover = primary2Color;
          numbered_active_underline_color = primary1Color;
          occupied = secondary2Color;
        };
      };
      menus = {
        monochrome = true;
        background = background1Color;
        cards = background2Color;
        dimtext = secondary2Color;
        feinttext = secondary1Color;
        label = primary2Color;
        text = primary1Color;
        border.color = secondary1Color;
        buttons.active = secondary1Color;
        buttons.default = primary1Color;
        buttons.disabled = passiveColor;
        buttons.text = background1Color;
        dropdownmenu.divider = secondary1Color;
        iconbuttons.active = primary1Color;
        iconbuttons.passive = passiveColor;
        icons.active = primary1Color;
        icons.passive = secondary1Color;
        listitems.active = primary2Color;
        listitems.passive = passiveColor;
        slider.background = secondary1Color;
        slider.backgroundhover = secondary2Color;
        slider.primary = primary1Color;
        slider.puck = background1Color;
        switch.disabled = secondary1Color;
        switch.enabled = primary1Color;
        switch.puck = background1Color;
        tooltip.background = background2Color;
        tooltip.text = primary1Color;
        menu = {
          bluetooth.scroller.color = primary1Color;
          network.scroller.color = primary1Color;
          notifications = {
            pager.background = background2Color;
            pager.button = primary1Color;
            pager.label = primary2Color;
            scrollbar.color = primary1Color;
          };
        };
      };
    };
    notification = {
      actions.background = primary1Color;
      actions.text = background2Color;
      background = background2Color;
      border = secondary1Color;
      close_button.background = passiveColor;
      close_button.label = background2Color;
      label = primary2Color;
      labelicon = primary2Color;
      text = primary1Color;
      time = passiveColor;
    };
    osd = {
      bar_color = primary1Color;
      bar_container = background2Color;
      bar_empty_color = secondary1Color;
      bar_overflow_color = primary2Color;
      icon = background2Color;
      icon_container = primary1Color;
      label = primary2Color;
    };
  };
in
{
  sops = {
    secrets."weather_api_key" = { };
    templates."weather-api-key" = {
      content = ''
        { "weather_api_key": "${config.sops.placeholder."weather_api_key"}" }
      '';
      owner = config.users.users.mp.name;
    };
  };

  home-manager.users.mp = {
    home.packages = with pkgs; [ adwaita-icon-theme ];

    programs.hyprpanel = {
      enable = true;
      settings = {
        # Merge "Configuration" settings (below) with "Theming" settings (customTheme).
        theme = lib.attrsets.recursiveUpdate customTheme {
          font = {
            size = "1.1rem";
            weight = 500;
          };
          bar = {
            menus.enableShadow = true;
            buttons = {
              enableBorders = true;
              borderSize = "0.04em";
              y_margins = "0.2em";
              spacing = "0.2em";
            };
            outer_spacing = "0.2em";
            layer = "bottom";
          };
          notification.enableShadow = true;
          osd.enableShadow = true;
        };
        bar = {
          layouts = {
            "*" = {
              left = [
                "power"
                "workspaces"
              ];
              middle = [
                "notifications"
                "clock"
                "hypridle"
              ];
              right = [
                "netstat"
                "network"
                "bluetooth"
                "volume"
                "microphone"
                "systray"
              ];
            };
            "2" = {
              extends = "*";
              left = [ "workspaces" ];
              right = [
                "volume"
                "systray"
              ];
            };
          };
          workspaces = {
            monitorSpecific = false;
            showWsIcons = true;
            showApplicationIcons = true;
            showAllActive = false;
            workspaces = 1;
          };
          network = {
            showWifiInfo = true;
            truncation_size = 16;
          };
          clock.format = "%a  %Y-%m-%d  %H:%M:%S";
          notifications = {
            show_total = true;
            hideCountWhenZero = true;
          };
          customModules = {
            netstat = {
              dynamicIcon = true;
              round = false;
            };
            power.rightClick = "hyprpanel toggleWindow settings-dialog";
          };
        };
        notifications = {
          showActionsOnHover = true;
          clearDelay = 0;
          autoDismiss = true;
        };
        menus.clock = {
          time.military = true;
          weather = {
            location = "Tampere";
            key = "${config.sops.templates."weather-api-key".path}";
            unit = "metric";
            interval = 300000;
          };
        };
      };
    };
  };
}
