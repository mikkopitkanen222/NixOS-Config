# nixos-config/users/desknix-mp/bash.nix
# Configure Bash shell for user 'mp' on host 'desknix'.
{ ... }:
{
  home-manager.users.mp = {
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
        ".." = "cd ..";
        "..." = "cd ../..";
        "ll" = "ls -l";
        "code" = "codium";
      };
      initExtra = ''
        tabs -2
      '';
    };

    programs.powerline-go = {
      enable = true;
      settings = {
        hostname-only-if-ssh = true;
        numeric-exit-codes = true;
      };
      extraUpdatePS1 = ''
        PS1="\n$PS1"
      '';
      newline = true;
      modules = [
        "nix-shell"
        "venv"
        "user"
        "host"
        "ssh"
        "cwd"
        "perms"
        "git"
        "hg"
        "jobs"
        "exit"
      ];
    };
  };
}
