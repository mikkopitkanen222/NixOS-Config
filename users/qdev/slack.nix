{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.slack;
in
{
  options.mp222.slack = {
    enable = lib.mkEnableOption "Slack";

    package = lib.mkPackageOption pkgs "slack" { };

    autostart = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Launch Slack on login.";
      };

      hidden = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Hide the window on startup.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.mp = {
      home.packages = [ cfg.package ];

      systemd.user.services.slack = lib.mkIf cfg.autostart.enable {
        Unit = {
          Description = "Run Slack on startup.";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service.ExecStart =
          "${lib.getExe pkgs.slack} -s" + (if cfg.autostart.hidden then " -u" else "");
        Install.WantedBy = [
          "graphical-session.target"
          "tray.target"
        ];
      };
    };
  };
}
