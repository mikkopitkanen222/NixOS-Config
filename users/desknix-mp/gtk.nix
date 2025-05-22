# nixos-config/users/desknix-mp/gtk.nix
# Configure GTK for user 'mp' on host 'desknix'.
{ ... }:
{
  home-manager.users.mp = {
    gtk = {
      enable = true;
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
