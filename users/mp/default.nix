# mp user configuration.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  userName = "mp";

  userConfig = {
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

      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          twxs.cmake
          ms-vscode.cmake-tools
          llvm-vs-code-extensions.vscode-clangd
        ];
      };
    };

    build.user.${userName} = {
      nano.usableDefaults = true;
      bash =
        let
          green = {
            r = 0;
            g = 255;
            b = 43;
          };
          cyan = {
            r = 0;
            g = 215;
            b = 255;
          };
          red = {
            r = 255;
            g = 0;
            b = 78;
          };
          magenta = {
            r = 102;
            g = 44;
            b = 86;
          };
        in
        {
          usableDefaults = true;
          gitPrompt = true;
          bashPrompt = [
            {
              foreground = green;
              text = "\\n\\u@\\h";
            }
            {
              foreground = cyan;
              text = " \\w";
            }
            {
              foreground = red;
              text = " $(__git_ps1 \"(%s)\")";
            }
            { text = "\\n\\$\\040"; }
          ];
          devshellPrompt = [
            {
              foreground = green;
              background = magenta;
              text = "\\n\\u@\\h";
            }
            {
              foreground = cyan;
              text = " \\w";
            }
            {
              foreground = red;
              text = " $(__git_ps1 \"(%s)\")";
            }
            { text = "\\n\\$\\040"; }
          ];
        };

      calculator.enable = true;
      terminal.enable = true;

      discord.enable = true;

      gimp = {
        enable = true;
        package = pkgs.gimp-with-plugins;
      };
      libreoffice = {
        enable = true;
        package = pkgs.libreoffice-qt6-fresh;
        spellcheck = {
          enable = true;
          languages = [ "en_US" ];
        };
      };
      shotcut.enable = true;

      image-viewer.enable = true;
      osrs.enable = true;
      spotify = {
        enable = true;
        spicetify.enable = true;
      };

      obsidian.enable = true;
      plasma-browser-integration.enable = true;
      protondrive.enable = true;
      protonmail-bridge.enable = true;
      protonpass.enable = true;
      protonvpn.enable = true;
    };
  };
in
{
  options = {
    build.userNames = lib.mkOption { type = lib.types.listOf (lib.types.enum [ userName ]); };
  };

  config = lib.mkIf (builtins.elem userName config.build.userNames) userConfig;
}
