{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.boot;
in
{
  options.mp222.boot = {
    enable = lib.mkEnableOption "the latest kernel and boot loader settings";

    numlock = lib.mkEnableOption "numlock before the LUKS passphrase prompt";

    splash = lib.mkEnableOption "a boot splash";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
        hardware.enableRedistributableFirmware = true;

        boot = {
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          initrd.systemd.enable = true;
        };

        # Press space during boot to show the boot menu.
        boot.loader.timeout = lib.mkDefault 0;
      }
      (lib.mkIf cfg.numlock {
        boot.initrd.systemd = {
          initrdBin = [ pkgs.kbd ];
          services.activateNumlock = {
            description = "Activate numlock before prompting for a LUKS decryption passphrase.";
            wantedBy = [ "initrd.target" ];
            before = [ "sysinit.target" ];
            unitConfig.DefaultDependencies = "no";
            serviceConfig.Type = "oneshot";
            script = ''
              INITTY=/dev/tty[1-6]
              for tty in $INITTY; do
                /bin/setleds -D +num < $tty
              done
            '';
          };
        };
      })
      (lib.mkIf cfg.splash {
        boot = {
          plymouth = {
            enable = true;
            theme = lib.mkDefault "splash";
            themePackages = [
              (pkgs.adi1090x-plymouth-themes.override {
                selected_themes = [ config.boot.plymouth.theme ];
              })
            ];
          };
          loader.systemd-boot.consoleMode = "max";

          # Enable silent boot.
          consoleLogLevel = 4;
          initrd.verbose = false;
          kernelParams = [
            "quiet"
            "rd.udev.log_level=3"
            "rd.systemd.show_status=auto"
          ];
        };
      })
    ]
  );
}
