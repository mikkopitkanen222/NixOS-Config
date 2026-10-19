{ config, lib, ... }:
let
  cfg = config.mp222.profiles.work;
in
{
  options.mp222.profiles.work = {
    enable = lib.mkEnableOption "the work user profile";
  };

  config = lib.mkIf (cfg.enable && config.mp222.profiles.workstation.enable) {
    mp222 = lib.mkDefault {
      # Apps
      slack = {
        enable = true;
        autostart.enable = true;
      };
    };

    programs.dank-material-shell.settings = {
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenNotificationMode = 1;
    };

    programs.chromium.extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
    ];
  };
}
