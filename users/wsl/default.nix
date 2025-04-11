# Configuration for user "wsl".
{ config, lib, ... }:
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
        extraGroups = [ "wheel" ];
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
        nix.settings = {
          bash-prompt = ''\n\001\033[1;32m\002\u@\h \001\033[1;34m\002\w \001\033[1;35m\002$(__git_ps1 "(%s)")\001\033[0m\002\n\$\040'';
        };

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
