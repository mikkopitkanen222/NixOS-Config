# nixos-config/users/qdev-mp/gtk.nix
# Configure GTK for user 'mp' on host 'qdev'.
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
