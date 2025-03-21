# wsl user configuration.
{
  config,
  lib,
  ...
}:
let
  userName = "wsl";
  username = "mp";

  userConfig = {
    wsl.defaultUser = username;

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };

    home-manager.users.${username} = {
      programs.home-manager.enable = true;

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };

      # Shortened script from github.com/sonowz/vscode-remote-wsl-nixos
      home.file.".vscode-server/server-env-setup".text = ''
        PATH=$PATH:/run/current-system/sw/bin/
        PKGS_EXPRESSION=nixpkgs/nixos-unstable#pkgs
        VSCODE_SERVER_DIR="/home/${username}/.vscode-server"

        nix shell $PKGS_EXPRESSION.patchelf $PKGS_EXPRESSION.stdenv.cc -c bash -c "
          for versiondir in $VSCODE_SERVER_DIR/bin/*/; do
            # Currently only "libstdc++.so.6" needs to be patched
            patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node_modules/node-pty/build/Release/spawn-helper\"
            patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node\"
          done
        "
      '';

      programs.git = {
        enable = true;
        userName = "Mikko Pitkänen";
        userEmail = "mikko.pitkanen@quux.fi";
        signing.signByDefault = true;
        signing.key = "66E93779B6C5AA0A!";
      };
    };
  };
in
{
  config = lib.mkMerge [
    ({ system.userNames' = [ userName ]; })
    (lib.mkIf (builtins.elem userName config.system.userNames) userConfig)
  ];
}
