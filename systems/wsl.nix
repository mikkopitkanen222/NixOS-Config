# Configuration for system "wsl".
{ inputs, pkgs, ... }:
{
  imports = [
    # Common
    {
      nix = {
        # Our configurations use flakes ...
        settings.experimental-features = "nix-command flakes";
        # ... making channels obsolete.
        channel.enable = false;
        # Prefer to always use full flake URIs.
        registry = { };
        # Delete old profiles and unreachable objects from the Nix store.
        # Does not delete the current generation of any profile.
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 5d";
        };
        # Help nixd find modules.
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      };

      home-manager = {
        # Use the same instance of pkgs for NixOS and home-manager.
        useGlobalPkgs = true;
        # Install packages to /etc/profiles instead of ~/.nix-profile.
        # Required for 'nixos-rebuild build-vm'.
        useUserPackages = true;
      };

      environment.systemPackages = with pkgs; [
        tree
        wget
      ];
    }
    # Locale
    {
      time.timeZone = "Europe/Helsinki";
      i18n = {
        defaultLocale = "fi_FI.UTF-8";
        extraLocaleSettings = {
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
    # Smartcard Crypto
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
      # They're set for all users, since shared options (above) are touched anyway.)
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
  ];
}
