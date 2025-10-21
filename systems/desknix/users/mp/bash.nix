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
  };
}
