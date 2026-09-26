# https://github.com/savedra1/clipse
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.clipse;
in
{
  options.mp222.clipse = {
    enable = lib.mkEnableOption "clipse";
    addWindowrule = lib.mkOption {
      type = lib.types.bool;
      description = "Whether to add a Hyprland windowrule.";
      default = true;
      example = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.clipse = {
        enable = true;
        imageDisplay.type = lib.mkDefault "kitty";
        theme = {
          useCustomTheme = lib.mkDefault true;
          TitleFore = lib.mkDefault "#848484";
          TitleBack = lib.mkDefault "#00000000";
          TitleInfo = lib.mkDefault "#585858";
          FilterPrompt = lib.mkDefault "#848484";
          FilterInfo = lib.mkDefault "#585858";
          FilterText = lib.mkDefault "#ffffff";
          FilterCursor = lib.mkDefault "#848484";
          NormalTitle = lib.mkDefault "#d0a028";
          NormalDesc = lib.mkDefault "#54157e";
          DimmedTitle = lib.mkDefault "#685014";
          DimmedDesc = lib.mkDefault "#2a0a3f";
          SelectedTitle = lib.mkDefault "#d39c87";
          SelectedDesc = lib.mkDefault "#975da3";
          SelectedBorder = lib.mkDefault "#683030";
          SelectedDescBorder = lib.mkDefault "#683030";
          StatusMsg = lib.mkDefault "#d39c87";
          PinIndicatorColor = lib.mkDefault "#683030";
          HelpKey = lib.mkDefault "#826419";
          HelpDesc = lib.mkDefault "#35044f";
          DividerDot = lib.mkDefault "#00000000";
          PageActiveDot = lib.mkDefault "#d0a028";
          PageInactiveDot = lib.mkDefault "#54157e";
          PreviewedText = lib.mkDefault "#ffffff";
          PreviewBorder = lib.mkDefault "#683030";
        };
      };

      home.packages = [ pkgs.wl-clipboard ];
    })
    (lib.mkIf (cfg.enable && cfg.addWindowrule) {
      wayland.windowManager.hyprland.settings.windowrule = [
        {
          name = "float-clipse";
          "match:class" = "clipse";
          float = "on";
          size = "624 702";
          center = "on";
        }
      ];
    })
  ];
}
