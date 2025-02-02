# Enable smartcards (Yubikey) for signing, encryption, and authentication.
# https://nixos.wiki/wiki/Yubikey
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.scCrypto;
in
{
  options.scCrypto = {
    enable = lib.mkEnableOption "PGP and SSH smartcard functionality.";

    pinentryPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pinentry-curses;
      description = "Program used to enter the smartcard PIN.";
    };
  };

  config = lib.mkIf cfg.enable {
    # For SSH, we're using gpg-agent instead of ssh-agent.
    # ssh-agent can't use GPG keys for SSH authentication.
    programs.ssh.startAgent = false;

    # gpg-agent can use SSH keys and GPG keys stored on a smartcard.
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = cfg.pinentryPackage;
      settings = {
        default-cache-ttl = 60;
      };
    };

    # Yubikey smartcard mode (CCID) requires the PCSC-Lite daemon.
    services.pcscd.enable = true;

    # (These settings are available only through home-manager.
    # They're set for all users, since shared options are touched anyway.)
    home-manager.sharedModules = [
      {
        programs.gpg = {
          enable = true;
          # GnuPG scdaemon conflicts with pcscd.
          # By disabling the integrated GnuPG support for CCID,
          # GnuPG falls back to using the PCSC-Lite daemon instead.
          scdaemonSettings.disable-ccid = true;
        };
      }
    ];
  };
}
