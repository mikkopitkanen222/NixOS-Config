# Configuration for user "mp".
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Build this user by setting the attribute "system.userNames" in flake.nix.
  userName = "mp";

  # Configure programs, services, and files for this user:
  userConfig = lib.mkMerge [
    # User
    {
      users.users.${userName} = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        openssh.authorizedKeys.keyFiles = [ ./key/yubikey.pub ];
      };

      home-manager.users.${userName} = {
        programs.home-manager.enable = true;
        home = {
          username = userName;
          homeDirectory = "/home/${userName}";
          stateVersion = "24.11";
        };
      };
    }
    # Programs
    {
      unfree.allowedPackages = [
        "obsidian"
        "spotify"
      ];

      home-manager.users.${userName} = {
        nix.settings = {
          bash-prompt = ''\n\001\033[1;32m\002\u@\h \001\033[1;34m\002\w \001\033[1;35m\002$(__git_ps1 "(%s)")\001\033[0m\002\n\$\040'';
        };

        programs.git = {
          enable = true;
          userName = "Mikko Pitkänen";
          userEmail = "mikko.pitkanen.code@pm.me";
          signing.signByDefault = true;
          signing.key = null; # Let GnuPG pick the key based on userEmail.
          extraConfig = {
            init.defaultBranch = "master";
            core.pager = "less -x2";
          };
        };

        programs.bash = {
          enable = true;
          historyControl = [ "ignoreboth" ];
          historyFile = ".bash_history";
          historyIgnore = [
            "clear"
            "ls"
            "pwd"
            "cd"
            "exit"
            "git log"
            "git status"
          ];
          shellAliases = {
            "ll" = "ls -l";
            ".." = "cd ..";
          };
          initExtra = ''
            . /etc/profiles/per-user/${userName}/share/bash-completion/completions/git
            . /etc/profiles/per-user/${userName}/share/bash-completion/completions/git-prompt.sh
            export GIT_PS1_SHOWDIRTYSTATE=1
            PS1='\n\001\033[1;32m\002\u@\h \001\033[1;34m\002\w \001\033[1;31m\002$(__git_ps1 "(%s)")\001\033[0m\002\n\$ '
          '';
        };

        programs.chromium = {
          enable = true;
          package = pkgs.brave;
          extensions = [
            "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
            "cimiefiiaegbelhefglklhhakcgmhkai" # Plasma Integration
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

        programs.vscode = {
          enable = true;
          package = pkgs.vscodium;
          profiles.default.extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            ms-vscode.cmake-tools
            llvm-vs-code-extensions.vscode-clangd
          ];
        };

        home.packages = with pkgs; [
          kdePackages.plasma-browser-integration
          bolt-launcher
          obsidian
          qalculate-qt
          spotify
          spicetify-cli
          vesktop
        ];
      };
    }
  ];
in
{
  imports = [ ../../modules/unfree.nix ];

  config = lib.mkMerge [
    # Merge this user's userName to the list of all userNames.
    ({ system.allUserNames = [ userName ]; })
    # Build this user's configuration if its userName is listed in flake.nix.
    (lib.mkIf (builtins.elem userName config.system.userNames) userConfig)
  ];
}
