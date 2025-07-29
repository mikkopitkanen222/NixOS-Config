# nixos-config/users/lapnix-mp/nano.nix
# Configure Nano editor for user 'mp' on host 'lapnix'.
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
