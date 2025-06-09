# Configure user language settings.
#
# This module can be imported by user "wsl" config.
{ ... }:
{
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
}
