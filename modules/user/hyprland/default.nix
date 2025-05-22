# Configuration for user module "hyprland".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options = {
      hyprland = {
        enable = lib.mkEnableOption "Hyprland";
      };
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.hyprland;
    in
    lib.mkIf module.enable {
      home.sessionVariables.NIXOS_OZONE_WL = "1";

      home.packages = with pkgs; [
        hyprland-qt-support
        hyprland-qtutils
        hyprls
        hyprpicker
        hyprpolkitagent
        hyprsysteminfo
      ];

      xdg.configFile."hypr/application-style.conf".source = ./application-style.conf;
      xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = lib.mkMerge [
    (lib.mkIf (builtins.any (mod: mod.hyprland.enable) (builtins.attrValues cfg)) {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    })
    { home-manager.users = builtins.mapAttrs moduleConfig cfg; }
  ];
}
