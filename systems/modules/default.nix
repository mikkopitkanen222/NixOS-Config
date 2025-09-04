# nixos-config/systems/desknix-daily/default.nix
# Configure system 'daily' on host 'desknix'.
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.systemRoles;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.vscode-server.nixosModules.default
  ];

  options = {
    systemRoles = {
      gaming = {
        clients = lib.mkEnableOption "gaming clients";
        servers = lib.mkEnableOption "gaming servers";
      };
    };
  };

  config = lib.mkMerge [
    {
      nix = {
        # The system config makes use of modern flakes, disabling old channels.
        settings.experimental-features = "nix-command flakes";
        channel.enable = false;

        # Help nixd find modules.
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        # Delete old profiles and unreachable objects from the Nix store.
        # Does not delete the current generation of any profile.
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 7d";
        };
      };

      home-manager = {
        # Use the same instance of pkgs for NixOS and Home Manager.
        useGlobalPkgs = true;

        # Install packages to /etc/profiles instead of ~/.nix-profile.
        # Required for 'nixos-rebuild build-vm'.
        useUserPackages = true;
      };

      # Deterministic, declarative user configuration.
      users.mutableUsers = false;

      # Lone packages without further config are installed here:
      environment.systemPackages = with pkgs; [ tree ];

      nixpkgs = {
        config.allowUnfree = true;
        # Overlays output by our flake are enabled here:
        overlays = [ inputs.self.outputs.overlays.spotify-player-fix ];
      };
    }
    (lib.mkIf cfg.gaming.clients { programs.steam.enable = true; })
    (lib.mkIf cfg.gaming.servers {
      environment.systemPackages = [ config.services.factorio.package ];
      # Should this be server specific? I can't run a server on the same savegame on two hosts anyway.
      services.factorio = rec {
        enable = true;
        package = pkgs.factorio-headless;
        requireUserVerification = false;
        saveName = "SPAGEtti";
        openFirewall = true;
        nonBlockingSaving = true;
        loadLatestSave = true;
        game-name = "SPAGEtti";
        extraSettingsFile = "/var/lib/${config.services.factorio.stateDirName}/${game-name}-settings";
        extraSettings = {
          max_players = 2;
        };
        description = "foofoo";
        autosave-interval = 3;
        admins = [
          "Mikkeli222"
          "Valdos"
        ];
      };
    })
    {
      # Not for WSL
      networking.wireless.iwd = {
        enable = true;
        settings = {
          Settings = {
            AutoConnect = true;
          };
        };
      };

      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        iwgtk
      ];
    }
    {
      time.timeZone = "Europe/Helsinki";
      i18n.defaultLocale = "fi_FI.UTF-8";
      # extraLocaleSettings set in Home Manager.

      console.keyMap = "fi";
      # Keyboard config in Home Manager.
    }
    {
      # Not for WSL
      environment.systemPackages = [ pkgs.overskride ];

      # Make sure bluetooth.service is enabled / starts at boot.
      systemd.services.bluetooth.wantedBy = [ "multi-user.target" ];
    }
    {
      # Not for WSL
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };
    }
    {
      # Not for WSL
      security.pam = {
        u2f = {
          enable = true;
          settings = {
            origin = "pam://mp222";
            authfile = config.sops.secrets."u2f_keys".path;
            cue = true;
          };
        };
        services = {
          login.u2fAuth = true;
          sudo.u2fAuth = true;
        };
      };

      services.openssh = {
        enable = true;
        settings = {
          # Allow login using crypto keys only.
          KbdInteractiveAuthentication = false;
          PasswordAuthentication = false;
          # Root user does not need to login remotely.
          PermitRootLogin = "no";
        };
      };
    }
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
    {
      sops = {
        defaultSopsFile = "${inputs.nixos-secrets}/${config.networking.hostName}.yaml";
        defaultSopsFormat = "yaml";
        age = {
          generateKey = false;
          sshKeyPaths = [ ];
        };
        gnupg = {
          home = "/var/lib/sops";
          sshKeyPaths = [ ];
        };
        secrets = {
          # <-- Host specific; These are for Desknix
          "passwd_mp".neededForUsers = true;
          "openssh_mp" = { };
          "u2f_keys" = {
            group = config.users.users.mp.group;
            mode = "0440";
          };
        };
      };
    }
    { services.vscode-server.enable = true; }
  ];
}
