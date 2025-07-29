# nixos-config/users/wsl-mp/nano.nix
# Configure Nano editor for user 'mp' on host 'wsl'.
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
