# Configure bash and nano.
#
# This module can be imported by user "mp" config.
{ ... }:
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

  xdg.configFile."nano/nanorc".text = ''
    set autoindent
    set linenumbers
    set mouse
    set positionlog
    set tabsize 2
  '';
}
