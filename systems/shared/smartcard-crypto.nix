# Configure smartcard (Yubikey) based authentication, encryption, and signing.
# https://nixos.wiki/wiki/Yubikey
# https://ludovicrousseau.blogspot.com/2019/06/gnupg-and-pcsc-conflicts.html
#
# This module can be imported by all system configs.
{ pkgs, ... }:
{
  # For SSH, we're using gpg-agent instead of ssh-agent.
  # ssh-agent can't use GPG keys for SSH authentication.
  programs.ssh.startAgent = false;

  # gpg-agent can use SSH keys and GPG keys stored on a smartcard.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Yubikey smartcard mode (CCID) requires the PCSC-Lite daemon.
  services.pcscd.enable = true;

  # (These settings are available only through home-manager.
  # They're set for all users, since system-level options are touched anyway.)
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
}
