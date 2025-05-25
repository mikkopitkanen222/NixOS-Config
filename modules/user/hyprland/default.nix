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
        brightnessctl
        fira
        font-awesome
        icomoon-feather
        nerd-fonts.space-mono
        roboto
        hypridle
        hyprland-qt-support
        hyprland-qtutils
        hyprlock
        hyprls
        hyprpicker
        hyprpolkitagent
        hyprsysteminfo
        waybar
      ];

      xdg.configFile."hypr/application-style.conf".source = ./application-style.conf;
      xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
      xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
      xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
      xdg.configFile."waybar".source = ./waybar;

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      # Todo: mako, tofi, clipse, File manager: nnn > lf
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
      security.pam.services = lib.mkIf config.build.system.pam.enable { hyprlock.u2fAuth = true; };
    })
    { home-manager.users = builtins.mapAttrs moduleConfig cfg; }
  ];
}
