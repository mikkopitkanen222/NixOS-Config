{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.profiles.wsl;
in
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  options.mp222.profiles.wsl = {
    enable = lib.mkEnableOption "the WSL system profile";
  };

  config = lib.mkIf cfg.enable {
    wsl.enable = true;
    environment.systemPackages = [ pkgs.wget ];

    mp222 = lib.mkDefault {
      # Infra
      vscodeServer.enable = true;
      yubikey.enable = true;
    };
  };
}
