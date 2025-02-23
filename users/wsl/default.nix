# wsl user configuration.
{
  config,
  lib,
  ...
}:
let
  userName = "wsl";
  username = "mp";

  userConfig = {
    wsl.defaultUser = username;

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };

    home-manager.users.${username} = {
      programs.home-manager.enable = true;

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.11";
      };

      programs.git = {
        enable = true;
        userName = "Mikko Pitkänen";
        userEmail = "mikko.pitkanen@quux.fi";
        signing.signByDefault = true;
        signing.key = "66E93779B6C5AA0A!";
      };
    };
  };
in
{
  config = lib.mkMerge [
    ({ system.userNames' = [ userName ]; })
    (lib.mkIf (builtins.elem userName config.system.userNames) userConfig)
  ];
}
