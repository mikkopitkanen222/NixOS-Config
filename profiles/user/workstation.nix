{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.profiles.workstation;
in
{
  options.mp222.profiles.workstation = {
    enable = lib.mkEnableOption "the workstation user profile";
  };

  config = lib.mkIf cfg.enable {
    mp222 = lib.mkDefault {
      # Apps
      btop.enable = true;
      chromium.enable = true;
      nnn.enable = true;
      obsidian.enable = true;
      vscodium.enable = true;
      # Desktop
      clipse.enable = true;
      dank.enable = true;
      gtk.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      userDirs.enable = true;
      walls.enable = true;
      # Infra
      udiskie.enable = true;
    };

    home.packages = [
      pkgs.qalculate-qt
      pkgs.qimgv
      pkgs.vlc
    ];
  };
}
