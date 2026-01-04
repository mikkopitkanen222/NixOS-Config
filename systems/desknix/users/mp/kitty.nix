# https://github.com/kovidgoyal/kitty
{ config, pkgs, ... }:
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
          backgrounds =
            config.home-manager.users.mp.services.hyprpaper.settings.wallpaper;
          bg-image = (builtins.head backgrounds).path;
        in
        {
          background_image = "${bg-image}";
          background_tint = 0.25;
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
