# Home-manager configuration for user "wsl".
{ lib, pkgs, ... }:
{
  home-manager.users.wsl = lib.mkMerge [
    # Common
    {
      programs.home-manager.enable = true;
      home = {
        username = "wsl";
        homeDirectory = "/home/wsl";
        stateVersion = "24.11";
      };
      # Packages without further config:
      home.packages = with pkgs; [ nixd ];
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
          . /etc/profiles/per-user/wsl/share/bash-completion/completions/git
          . /etc/profiles/per-user/wsl/share/bash-completion/completions/git-prompt.sh
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

      home.file.".vscode-server/server-env-setup".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/sonowz/vscode-remote-wsl-nixos/69a0156a137fa74c06e3967e52c52a71ee7ddb71/server-env-setup";
        hash = "sha256-KJ0tEuY+hDJbBQtJj8nSNk17FHqdpDWTpy9/DLqUFaM="; # FIXME
      };

      programs.git = {
        enable = true;
        userName = "Mikko Pitkänen";
        userEmail = "change.me@work";
        extraConfig = {
          core.pager = "less -x2";
        };
      };
    }
  ];
}
