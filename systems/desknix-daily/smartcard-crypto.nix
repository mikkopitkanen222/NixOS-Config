# nixos-config/systems/desknix-daily/smartcard-crypto.nix
# Configure Yubikey based authentication, encryption, and signing for system 'daily' on host 'desknix'.
# https://nixos.wiki/wiki/Yubikey
# https://ludovicrousseau.blogspot.com/2019/06/gnupg-and-pcsc-conflicts.html
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
    settings = {
      default-cache-ttl = 30;
      max-cache-ttl = 60;
    };
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
        # GPG hardening:
        settings = {
          personal-cipher-preferences = "AES256 AES192 AES";
          personal-digest-preferences = "SHA512 SHA384 SHA256";
          personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
          default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
          cert-digest-algo = "SHA512";
          s2k-digest-algo = "SHA512";
          s2k-cipher-algo = "AES256";
          charset = "utf-8";
          fixed-list-mode = true;
          no-comments = true;
          no-emit-version = true;
          keyid-format = "0xlong";
          list-options = "show-uid-validity";
          verify-options = "show-uid-validity";
          with-fingerprint = true;
          require-cross-certification = true;
          no-symkey-cache = true;
          use-agent = true;
          throw-keyids = true;
        };
      };
    }
  ];
}
