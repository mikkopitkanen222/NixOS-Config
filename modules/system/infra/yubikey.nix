# https://nixos.wiki/wiki/Yubikey
# https://ludovicrousseau.blogspot.com/2019/06/gnupg-and-pcsc-conflicts.html
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.yubikey;
in
{
  options.mp222.yubikey = {
    enable = lib.mkEnableOption "YubiKey support";
  };

  config = lib.mkIf cfg.enable {
    # For SSH, we're using gpg-agent instead of ssh-agent.
    # ssh-agent can't use GPG keys for SSH authentication.
    programs.ssh.startAgent = false;

    # gpg-agent can use SSH keys and GPG keys stored on a smart card.
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentry-qt opens a dialog in a graphical session and falls back to the
      # terminal elsewhere (e.g. over SSH). Qt is only pulled in on hosts that
      # already have it for DMS.
      pinentryPackage =
        if config.mp222.dank.enable then pkgs.pinentry-qt else pkgs.pinentry-curses;
      settings = {
        default-cache-ttl = 30;
        max-cache-ttl = 60;
      };
    };

    # YubiKey smart card mode (CCID) requires the PCSC-Lite daemon.
    services.pcscd.enable = true;
  };
}
