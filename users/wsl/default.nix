# Configuration for user "wsl".
{
  config,
  lib,
  ...
}:
let
  # Build this user by setting the attribute "system.userNames" in flake.nix.
  userName = "wsl";

  # Configure programs, services, and files for this user:
  userConfig = lib.mkMerge [
    # User
    {
      wsl.defaultUser = userName;

      users.users.${userName} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
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
      home-manager.users.${userName} = {
        programs.git = {
          enable = true;
          userName = "Mikko Pitkänen";
          userEmail = "mikko.pitkanen@quux.fi";
          signing.signByDefault = true;
          signing.key = "66E93779B6C5AA0A!";
          extraConfig = {
            core.pager = "less -x2";
          };
        };
      };
    }
    # Files
    {
      home-manager.users.${userName} = {
        # Shortened script from github.com/sonowz/vscode-remote-wsl-nixos
        home.file.".vscode-server/server-env-setup".text = ''
          PATH=$PATH:/run/current-system/sw/bin/
          PKGS_EXPRESSION=nixpkgs/nixos-unstable#pkgs
          VSCODE_SERVER_DIR="/home/${userName}/.vscode-server"

          nix shell $PKGS_EXPRESSION.patchelf $PKGS_EXPRESSION.stdenv.cc -c bash -c "
            for versiondir in $VSCODE_SERVER_DIR/bin/*/; do
              # Currently only "libstdc++.so.6" needs to be patched
              patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node_modules/node-pty/build/Release/spawn-helper\"
              patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node\"
            done
          "
        '';
      };
    }
  ];
in
{
  config = lib.mkMerge [
    # Merge this user's userName to the list of all userNames.
    ({ system.allUserNames = [ userName ]; })
    # Build this user's configuration if its userName is listed in flake.nix.
    (lib.mkIf (builtins.elem userName config.system.userNames) userConfig)
  ];
}
