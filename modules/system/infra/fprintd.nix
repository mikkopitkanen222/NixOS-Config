{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.fprintd;
in
{
  options.mp222.fprintd = {
    enable = lib.mkEnableOption "fingerprint authentication";
  };

  config = lib.mkIf cfg.enable {
    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = lib.mkDefault pkgs.libfprint-2-tod1-elan;
      };
    };
  };
}
