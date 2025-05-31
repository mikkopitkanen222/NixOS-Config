# Home-manager configuration for user "mp".
{ lib, pkgs, ... }:
{
  home-manager.users.mp = lib.mkMerge [
    # Common
    {
      programs.home-manager.enable = true;
      home = {
        username = "mp";
        homeDirectory = "/home/mp";
        stateVersion = "24.11";
      };
      # Packages without further config:
      home.packages = with pkgs; [
        # Downtime
        bolt-launcher
        proton-pass
        protonvpn-gui
        # Image, Music & Video Editors
        gimp-with-plugins
        shotcut
        # Image, Music & Video Viewers
        qimgv
        spicetify-cli # Remove, see spotify
        spotify # Switch to spotify-player & conf through HM
        vlc
        # Messengers
        vesktop # Conf through HM
        whatsie
        # Work
        hunspell
        hunspellDicts.en_US
        kitty # Conf through HM
        libreoffice-qt6-fresh
        nixd
        obsidian
        qalculate-qt
      ];
    }
    # Downtime
    {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
          "inomeogfingihgjfjlpeplalcfajhgai" # Chrome Remote Desktop

          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "jdocbkpgdakpekjlhemmfcncgdjeiika" # Absolute Enable Right Click

          "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
          "ajopnjidmegmdimjlfnijceegpefgped" # BetterTTV
          "mmioliijnhnoblpgimnlajmefafdfilb" # Shazam
          "baajncdfffcpahjjmhhnhflmbelpbpli" # Video Downloader
        ];
      };

      programs.thunderbird = {
        enable = true;
        profiles.mp = {
          isDefault = true;
        };
      };

      home.packages = [ pkgs.protonmail-bridge ];
      systemd.user.services.protonmail-bridge = {
        Unit = {
          Description = "Protonmail Bridge";
          After = [ "network-online.target" ];
        };
        Service = {
          Restart = "always";
          ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      # rclone.conf must be created imperatively due to 2FA.
      # Todo: Use (sops-nix, agenix, ?) etc. and create it here declaratively.
      programs.rclone = {
        enable = true;
        #  remotes.proton = {
        #    config = {
        #      type = "protondrive";
        #      username = "foobar";
        #      enable_caching = false;
        #    };
        #    secrets = {
        #      password = "/run/secrets/proton2";
        #      "2fa" = "/run/secrets/proton3";
        #    };
        #  };
      };

      systemd.user.services.protondrive-mount = {
        Unit = {
          Description = "Mount Proton Drive";
          After = [ "network-online.target" ];
        };
        Service = {
          Type = "notify";
          ExecStartPre = "/usr/bin/env mkdir -p /persist/proton";
          #ExecStart = "${pkgs.rclone}/bin/rclone --config=%h/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount proton: /persist/proton";
          ExecStart = "${pkgs.rclone}/bin/rclone --config=/persist/secrets/rclone.conf --vfs-cache-mode writes --ignore-checksum mount proton: /persist/proton";
          ExecStop = "/bin/fusermount -u /persist/proton/%i";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    }
    # Work
    {
      programs.bash = {
        enable = true;
        historyControl = [ "ignoreboth" ];
        historyIgnore = [
          "clear"
          "ls"
          "pwd"
          "cd"
          "exit"
        ];
        shellAliases = {
          "ll" = "ls -l";
          ".." = "cd ..";
          "..." = "cd ../..";
        };
        initExtra = ''
          . /etc/profiles/per-user/mp/share/bash-completion/completions/git
          . /etc/profiles/per-user/mp/share/bash-completion/completions/git-prompt.sh
          export GIT_PS1_SHOWDIRTYSTATE=1
          PS1='\n\033[38;2;0;255;43m\]\u@\h \033[38;2;0;215;255m\]\w\033[38;2;255;0;78m\]$(__git_ps1 " (%s)")\033[0m\]\n\$\040'
        '';
      };
      # Render first part with magenta background when inside Nix shell.
      nix.settings.bash-prompt = ''
        \n\033[38;2;0;255;43;48;2;102;44;86m\]\u@\h \033[38;2;0;215;255m\]\w\033[38;2;255;0;78m\]$(__git_ps1 " (%s)")\033[0m\]\n\$\040
      '';

      xdg.configFile."nano/nanorc".text = ''
        set autoindent
        set linenumbers
        set mouse
        set positionlog
        set tabsize 2
      '';

      programs.git = {
        enable = true;
        userName = "Mikko Pitkänen";
        userEmail = "mikko.pitkanen.code@pm.me";
        signing.signByDefault = true;
        extraConfig = {
          core.pager = "less -x2";
          init.defaultBranch = "master";
        };
      };

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            ms-vscode.cmake-tools
            llvm-vs-code-extensions.vscode-clangd
            wakatime.vscode-wakatime
          ];
          userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
        };
      };
    }
  ];
}
