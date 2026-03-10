{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
  };

  home-manager.users.mp = {
    programs.zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        highlight = "fg=#00ddff,bold";
      };
      defaultKeymap = "emacs";
      dotDir = "${config.home-manager.users.mp.xdg.configHome}/zsh";
      history = {
        append = true;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        saveNoDups = true;
        path = "${config.home-manager.users.mp.xdg.cacheHome}/.zsh_history";
      };
      historySubstringSearch = {
        enable = true;
        searchDownKey = "^[[1;5B";
        searchUpKey = "^[[1;5A";
      };
      initContent = ''
        key[CtrlLeft]="^[[1;5D"
        key[CtrlRight]="^[[1;5C"
        [[ -n "''${key[CtrlLeft]}"  ]] && bindkey "''${key[CtrlLeft]}"  backward-word
        [[ -n "''${key[CtrlRight]}" ]] && bindkey "''${key[CtrlRight]}" forward-word

        tabs -2
      '';
      setOptions = [
        "NO_AUTO_CD"
        "NO_BEEP"
        "HIST_REDUCE_BLANKS"
        "NOMATCH"
        "NOTIFY"
      ];
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "cursor"
        ];
      };
    };

    programs.nix-your-shell = {
      enable = true;
      enableZshIntegration = true;
      nix-output-monitor.enable = true;
    };
  };
}
