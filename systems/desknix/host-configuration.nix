{ pkgs, ... }:
{
  networking.hostName = "desknix";

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [
    {
      name = "Bluetooth: btmtk: accept too short WMT FUNC_CTRL events";
      patch = pkgs.fetchurl {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/patch/?id=162b1adeb057d28ad84fd8a03f3c50cf08db5c62";
        hash = "sha256-3iG77qRobyeMELrPR/khzWDJ4DpvUpr5PIghFPAMVoU=";
      };
    }
  ];

  boot.loader = {
    timeout = 0;
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.systemd = {
    initrdBin = [ pkgs.kbd ];
    services."activateNumlock" = {
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

  hardware = {
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
  };
}
