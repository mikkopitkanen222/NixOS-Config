# Configuration for user module "protonmail-bridge".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleOptions = {
    options.protonmail-bridge = {
      enable = lib.mkEnableOption "protonmail-bridge";
    };
  };

  moduleConfig =
    user: cfg:
    let
      module = cfg.protonmail-bridge;
    in
    lib.mkIf module.enable {
      home.packages = [ pkgs.protonmail-bridge ];

      systemd.user.services.protonmail-bridge = {
        Unit = {
          Description = "Protonmail Bridge";
          After = [ "network-online.target" ];
        };
        Service = {
          Restart = "always";
          ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };

  cfg = config.build.user;
in
{
  options = {
    build.user = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule moduleOptions); };
  };

  config = {
    home-manager.users = builtins.mapAttrs (moduleConfig) cfg;
  };
}
