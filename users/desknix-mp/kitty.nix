# nixos-config/users/desknix-mp/kitty.nix
# Configure Kitty terminal for user 'mp' on host 'desknix'.
# https://github.com/kovidgoyal/kitty
{
  config,
  lib,
  pkgs,
  ...
}:
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
          backgrounds = config.home-manager.users.mp.services.hyprpaper.settings.reload;
          bg-image = lib.strings.removePrefix "," (builtins.head backgrounds);
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
