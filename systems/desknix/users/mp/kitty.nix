# https://github.com/kovidgoyal/kitty
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.kitty = {
      enable = true;
      themeFile = "PaulMillr";
      font = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
        size = 12;
      };
      settings =
        let
          background = pkgs.fetchurl {
            url = "https://wallpapercave.com/download/brand-of-sacrifice-wallpapers-wp8812347";
            hash = "sha256-8h4kyDFE4CFDMBmxz6TbgbN0kCE0ACHSDqTd4Do8V9o=";
            # The requested URL returns error 403 when no user agent is set:
            curlOpts = "--user-agent 'Chrome/137.0.0.0'";
          };
        in
        {
          background_image = "${background}";
          background_tint = 0.99;
          cursor_stop_blinking_after = 0.0;
          tab_bar_style = "powerline";
          tab_powerline_style = "angled";
        };
    };

    xdg.configFile."kitty/quick-access-terminal.conf".text = ''
      lines 20
      background_opacity 0.8
      kitty_override background_image=none
      focus_policy on-demand
    '';
  };
}
