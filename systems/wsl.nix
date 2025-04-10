# Configuration for system "wsl".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Build this system by setting the attribute "system.systemName" in flake.nix.
  systemName = "wsl";

  # Configure programs and services for all users of this system:
  systemConfig = lib.mkMerge [
    # Nix
    {
      nix = {
        settings.experimental-features = "nix-command flakes";
        channel.enable = false;
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 5d";
        };
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
    # Locale
    {
      time.timeZone = "Europe/Helsinki";
      i18n = {
        defaultLocale = "fi_FI.UTF-8";
        extraLocaleSettings = {
          LANGUAGE = "en_US:en:C.UTF-8";
          LC_MESSAGES = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
        };
      };
      services.xserver.xkb = {
        layout = "fi";
        variant = "winkeys";
      };
      console.useXkbConfig = true;
    }
    # Smartcard
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
          default-cache-ttl = 20;
        };
      };

      # https://nixos.wiki/wiki/Yubikey
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
    }
    # Others
    {
      environment.systemPackages = with pkgs; [
        tree
        wget
      ];
    }
  ];
in
{
  config = lib.mkMerge [
    # Merge this system's systemName to the list of all systemNames.
    ({ system.allSystemNames = [ systemName ]; })
    # Build this system's configuration if its systemName is set in flake.nix.
    (lib.mkIf (config.system.systemName == systemName) systemConfig)
  ];
}
