# nixos-config/users/desknix-mp/kitty.nix
# Configure Kitty terminal for user 'mp' on host 'desknix'.
# https://github.com/kovidgoyal/kitty
{ ... }:
{
  home-manager.users.mp = {
    programs.kitty = {
      enable = true;
      themeFile = "PaulMillr";
      settings = {
        cursor_stop_blinking_after = 0.0;
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
      };
    };
    xdg.configFile."kitty/quick-access-terminal.conf".text = ''
      lines 20
      background_opacity 0.8
      focus_policy on-demand
    '';
  };
}
