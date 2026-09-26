{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.mp222.users = {
    #
  };

  config = lib.mkMerge [{
    home-manager = {
      useGlobalPkgs = true;
      # Install packages to /etc/profiles instead of ~/.nix-profile.
      # Required for 'nixos-rebuild build-vm'.
      useUserPackages = true;
      extraSpecialArgs = {
        osConfig = config;
      };
      users = lib.listToAttrs (
        map
          (user: {
            inherit (user) name;
            value = ../users/${user.name};
          })
          (
            lib.filter (
              user:
              let
                userHome = {
                  imports = [ ../users/${user.name} ];
                };
                usesHM = lib.attrByPath [ "programs" "home-manager" "enable" ] false userHome;
              in
              usesHM
            ) config.mp222.host.users
          )
      );
    };

    # Deterministic, declarative user configuration.
    users.mutableUsers = false;
  }];
}
