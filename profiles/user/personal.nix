{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.profiles.personal;
in
{
  options.mp222.profiles.personal = {
    enable = lib.mkEnableOption "the personal user profile";
  };

  config = lib.mkIf cfg.enable {
    mp222 = lib.mkDefault {
      # Apps
      proton.enable = true;
      thunderbird.enable = true;
      vesktop.enable = true;
      # Desktop
      dank.hueManager.enable = true;
    };

    programs.dank-material-shell.settings = {
      wifiNetworkPins.preferredWifi = [
        "TP-Link_E7D8_MLO"
        "TP-Link_E7D8"
      ];
      bluetoothDevicePins.preferredDevice = [ "00:0A:45:43:FD:74" ];
    };

    home.packages = [
      pkgs.bolt-launcher
      pkgs.spotify
      # Disable whatsie, as it depends on qt webengine 5.15, which is insecure and fails config eval.
      # Wait until whatsie migrates to qt webengine 6, or look for alternatives.
      # whatsie
    ];
  };
}
