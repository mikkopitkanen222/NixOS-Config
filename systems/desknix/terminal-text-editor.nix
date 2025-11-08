{ ... }:
{
  programs.nano = {
    enable = true;
    syntaxHighlight = true;
    nanorc = ''
      set autoindent
      set linenumbers
      set mouse
      set positionlog
      set tabsize 2
    '';
  };
}
