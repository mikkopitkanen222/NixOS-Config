# Configuration for host module "fprint".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.build.host.fprint;
in
{
  options = {
    build.host.fprint = {
      enable = lib.mkEnableOption "fingerprint reader";

      package = lib.mkPackageOption pkgs "fingerprint reader driver" {
        default = [ "libfprint-2-tod1-elan" ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    unfree.allowedPackages = [ (lib.getName cfg.package) ];

    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = cfg.package;
      };
    };
  };
}
