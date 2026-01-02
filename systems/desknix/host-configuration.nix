{ pkgs, ... }:
{
  networking.hostName = "desknix";

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
