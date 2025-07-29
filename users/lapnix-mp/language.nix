# nixos-config/users/lapnix-mp/language.nix
# Configure languages for user 'mp' on host 'lapnix'.
{ ... }:
{
  home-manager.users.mp = {
    home.language = {
      # Default:
      base = "fi_FI.UTF-8";
      # Overrides:
      messages = "en_US.UTF-8";
      numeric = "en_US.UTF-8";
    };

    home.keyboard = {
      model = "pc105";
      layout = "fi";
      variant = "winkeys";
    };
  };
}
