# mp user configuration.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  userName = "mp";
  username = userName;

  userConfig = {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keyFiles = [
        ./key/yubikey.pub
      ];
    };

    home-manager.users.${username} = {
      programs.home-manager.enable = true;

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };

      programs.git = {
        enable = true;
        userName = "Mikko Pitkänen";
        userEmail = "mikko.pitkanen.code@pm.me";
        signing.signByDefault = true;

        # Let GnuPG pick the key based on email.
        signing.key = null;
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
        vesktop
      ];
    };

    system.users.plasmaBrowserIntegration.${username}.enable = true;
    system.users.spotify.${username}.enable = true;
  };
in
{
  config = lib.mkMerge [
    ({ system.userNames' = [ userName ]; })
    (lib.mkIf (builtins.elem userName config.system.userNames) userConfig)
  ];
}
