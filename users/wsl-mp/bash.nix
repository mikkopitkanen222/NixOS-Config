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
      };
      initExtra = ''
        tabs -2
      '';
    };

    programs.powerline-go = {
      enable = true;
      settings = {
        hostname-only-if-ssh = true;
        mode = "flat";
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
