{ pkgs, ... }:
{
  home-manager.users.mp = {
    home.packages = with pkgs; [
      proton-pass
      protonvpn-gui
    ];

    services.protonmail-bridge.enable = true;

    # Removed rclone config for protondrive. Use the web app until such time
    # that linux is officially supported or a better alternative presents itself.
    # TODO: See if the android app is at all faster to use and if it can be used
    # from the command line.
    #
    # Using Protondrive with Rclone works, but after every system upgrade I get
    # - "Invalid access token",
    # - "Invalid refresh token", and
    # - "Incorrect login credentials"
    # and have to redo `rclone config`. Logging in repeatedly with "invalid"
    # credentials gets my account temporarily blocked, which is worrying.
    # Discussions on Reddit and Discourse have quotes from Proton customer
    # support stating that rclone is not supported and suggesting people should
    # stop using it, if they wish to continue using the service.
  };
}
