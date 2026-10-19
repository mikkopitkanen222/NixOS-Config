{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.users;

  enabledUsers = lib.filterAttrs (_: user: user.enable) cfg;

  userModule = lib.types.submodule {
    options = {
      enable = lib.mkEnableOption "the user's account on the host";

      admin = lib.mkEnableOption "the user's sudo privileges";

      home = lib.mkOption {
        type = lib.types.deferredModule;
        default = { };
        description = "The user's Home Manager configuration.";
      };
    };
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.mp222 = {
    users = lib.mkOption {
      type = lib.types.attrsOf userModule;
      default = { };
      description = "Users on this host.";
    };
  };

  config = {
    sops.secrets = lib.mapAttrs' (
      name: _: lib.nameValuePair "passwd_${name}" { neededForUsers = true; }
    ) enabledUsers;

    users = {
      # Deterministic and declarative user configurations only.
      mutableUsers = false;
      users = lib.mapAttrs (name: user: {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = lib.optional user.admin "wheel";
        hashedPasswordFile = config.sops.secrets."passwd_${name}".path;
      }) enabledUsers;
    };

    home-manager = {
      # Use the same instance of `pkgs` for NixOS and Home Manager.
      useGlobalPkgs = true;
      # Install packages to /etc/profiles instead of ~/.nix-profile.
      # Required for 'nixos-rebuild build-vm'.
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users = lib.mapAttrs (_: user: {
        imports = [ user.home ];
        home.stateVersion = lib.mkDefault config.system.stateVersion;
      }) enabledUsers;
    };
  };
}
