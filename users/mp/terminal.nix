# Configure kitty, a GPU based terminal.
# https://github.com/kovidgoyal/kitty
#
# This module can be imported by user "mp" config.
{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "PaulMillr";
    settings = {
      cursor_stop_blinking_after = 0.0;
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };
  };
}
