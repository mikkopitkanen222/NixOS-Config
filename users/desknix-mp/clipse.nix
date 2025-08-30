# nixos-config/users/desknix-mp/clipse.nix
# Configure Clipse for user 'mp' on host 'desknix'.
# https://github.com/savedra1/clipse
{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = [ pkgs.wl-clipboard ];

    # No need to do `clipse -listen` manually on login / in Hyprland config.
    # The HM module comes with a systemd unit `clipse.service`.
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float,class:(clipse)"
      "size 624 702,class:(clipse)"
    ];

    services.clipse = {
      enable = true;
      imageDisplay.type = "kitty";
      theme = {
        useCustomTheme = true;
        TitleFore = "#848484";
        TitleBack = "#00000000";
        TitleInfo = "#585858";
        FilterPrompt = "#848484";
        FilterInfo = "#585858";
        FilterText = "#ffffff";
        FilterCursor = "#848484";
        NormalTitle = "#d0a028";
        NormalDesc = "#54157e";
        DimmedTitle = "#685014";
        DimmedDesc = "#2a0a3f";
        SelectedTitle = "#d39c87";
        SelectedDesc = "#975da3";
        SelectedBorder = "#683030";
        SelectedDescBorder = "#683030";
        StatusMsg = "#d39c87";
        PinIndicatorColor = "#683030";
        HelpKey = "#826419";
        HelpDesc = "#35044f";
        DividerDot = "#00000000";
        PageActiveDot = "#d0a028";
        PageInactiveDot = "#54157e";
        PreviewedText = "#ffffff";
        PreviewBorder = "#683030";
      };
    };
  };
}
