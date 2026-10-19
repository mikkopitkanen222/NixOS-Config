{
  programs.nano = {
    enable = true;
    syntaxHighlight = true;
    # See `man nanorc`.
    nanorc = ''
      set atblanks
      set autoindent
      set constantshow
      set cutfromcursor
      set indicator
      set linenumbers
      set mouse
      set positionlog
      set smarthome
      set softwrap
      set tabsize 2
    '';
  };
}
