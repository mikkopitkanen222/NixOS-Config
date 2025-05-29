# Configure Proton Mail.
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
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
}
