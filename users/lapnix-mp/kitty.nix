# nixos-config/users/lapnix-mp/kitty.nix
# Configure Kitty terminal for user 'mp' on host 'lapnix'.
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
  };
}
