# https://github.com/philj56/tofi
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = [ pkgs.nerd-fonts.hack ];

    programs.tofi = {
      enable = true;
      settings = {
        hide-cursor = true;
        text-cursor = true;
        matching-algorithm = "fuzzy";
        drun-launch = true;
        ascii-input = true;
        font = "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFont-Regular.ttf";
        font-size = 21;
        background-color = "#0a0310f0";
        outline-width = 0;
        border-width = 6;
        border-color = "#54157ef0";
        text-color = "#54157e";
        prompt-text = "$ ";
        selection-color = "#d0a028";
        width = "860";
        height = "480";
        corner-radius = 15;
        hint-font = false;
      };
    };
  };
}
