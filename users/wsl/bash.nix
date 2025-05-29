# Configure bash and nano.
#
# This module can be imported by user "wsl" config.
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
    # PS1: [green]user@host [cyan]pwd [red]git-prompt
    initExtra = ''
      . /etc/profiles/per-user/wsl/share/bash-completion/completions/git
      . /etc/profiles/per-user/wsl/share/bash-completion/completions/git-prompt.sh
      export GIT_PS1_SHOWDIRTYSTATE=1
      PS1='\n\033[38;2;0;255;43m\]\u@\h \033[38;2;0;215;255m\]\w\033[38;2;255;0;78m\]$(__git_ps1 " (%s)")\033[0m\]\n\$\040'
    '';
  };
  # Render "user@host" part of PS1 with magenta background when inside Nix shell.
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
}
