{ config, lib, ... }:
let
  cfg = config.mp222.profiles.workstation;
in
{
  options.mp222.profiles.workstation = {
    enable = lib.mkEnableOption "the workstation system profile";
  };

  config = lib.mkIf cfg.enable {
    mp222 = lib.mkDefault {
      # Desktop
      dank.enable = true;
      hyprland.enable = true;
      # Infra
      bluetooth.enable = true;
      boot = {
        enable = true;
        numlock = true;
        splash = true;
      };
      networkmanager.enable = true;
      pipewire.enable = true;
      sshd.enable = true;
      u2f.enable = true;
      udisks.enable = true;
      vscodeServer.enable = true;
      yubikey.enable = true;
    };
  };
}
