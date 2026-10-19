# https://github.com/kovidgoyal/kitty
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.kitty;
in
{
  options.mp222.kitty = {
    enable = lib.mkEnableOption "kitty";
  };

  config = lib.mkIf cfg.enable {
    mp222.walls.wallpapers."kitty-teeth.jpg" = {
      url = "https://wallpapercave.com/download/brand-of-sacrifice-wallpapers-wp8812347";
      hash = "sha256-8h4kyDFE4CFDMBmxz6TbgbN0kCE0ACHSDqTd4Do8V9o=";
      outDir = "backgrounds";
    };

    programs.kitty = {
      enable = true;
      themeFile = "PaulMillr";
      font = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
        size = 12;
      };
      settings = {
        background_image = config.mp222.walls.wallpapers."kitty-teeth.jpg".path;
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
