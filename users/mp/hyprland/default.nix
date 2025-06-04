# Configure Hyprland.
# https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  # Launch Hyprland upon login in tty; There is no display manager.
  programs.bash.profileExtra = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  imports = [ ./file-manager.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    # Use the packages from the NixOS module.
    package = null;
    portalPackage = null;
    settings = { }; # Todo, monitors already done in hosts
  };

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
    tofi
    waybar
    wl-clipboard
  ];

  xdg.configFile."hypr/application-style.conf".source = ./application-style.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
  xdg.configFile."tofi/config".source = ./tofi-config;
  xdg.configFile."waybar".source = ./waybar;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.clipse = {
    enable = true;
    imageDisplay.type = "kitty";
  };
}
