{ ... }:
{
  home-manager.users.mp = {
    xdg.configFile."nano/nanorc".text = ''
      set autoindent
      set linenumbers
      set mouse
      set positionlog
      set tabsize 2
    '';
  };
}
