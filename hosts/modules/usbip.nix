# Configuration for host module "usbip".
# https://lgug2z.com/articles/yubikey-passthrough-on-wsl2-with-full-fido2-support/
{
  config,
  lib,
  pkgs,
  ...
}:
let
  usbipd-win-auto-attach = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dorssel/usbipd-win/v3.1.0/Usbipd/wsl-scripts/auto-attach.sh";
    hash = "sha256-KJ0tEuY+hDJbBQtJj8nSNk17FHqdpDWTpy9/DLqUFaM=";
  };

  cfg = config.build.host.usbip;
in
{
  options.build.host.usbip = {
    enable = lib.mkEnableOption "USB/IP integration";

    autoAttach = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "4-1" ];
      description = "Auto attach devices with provided Bus IDs.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      linuxPackages.usbip
      libfido2
    ];

    systemd = {
      services."usbip-auto-attach@" = {
        description = "Auto attach device having busid %i with usbip";
        after = [ "network.target" ];

        scriptArgs = "%i";
        path = [ pkgs.linuxPackages.usbip ];

        script = ''
          busid="$1"
          ip="$(grep nameserver /etc/resolv.conf | cut -d' ' -f2)"
          echo "Starting auto attach for busid $busid on $ip."
          source ${usbipd-win-auto-attach} "$ip" "$busid"
        '';
      };
      targets.multi-user.wants = builtins.map (
        busid: "usbip-auto-attach@${busid}.service"
      ) cfg.autoAttach;
    };
  };
}
