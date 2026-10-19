{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.proton;
in
{
  options.mp222.proton = {
    enable = lib.mkEnableOption "Proton apps";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.proton-pass
      pkgs.proton-vpn
    ];

    services.protonmail-bridge.enable = true;

    # Removed rclone config for protondrive. Use the web app until such time
    # that linux is officially supported or a better alternative presents itself.
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
