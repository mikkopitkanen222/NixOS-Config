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
        signing.key = null; # Let GnuPG pick the key based on userEmail.
        extraConfig = {
          init.defaultBranch = "master";
          core.pager = "less -x2";
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

      home.packages = with pkgs; [
        bolt-launcher
        obsidian
        qalculate-qt
        vesktop
      ];
    };

    build.user.${userName} = {
      nano.usableDefaults = true;
    };

    unfree.allowedPackages = [ "obsidian" ];

    build.users.plasmaBrowserIntegration.${userName}.enable = true;
    build.users.spotify.${userName}.enable = true;
  };
in
{
  options = {
    build.userNames = lib.mkOption { type = lib.types.listOf (lib.types.enum [ userName ]); };
  };

  config = lib.mkIf (builtins.elem userName config.build.userNames) userConfig;
}
