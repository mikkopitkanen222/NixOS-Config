# Configuration for system module "system-defaults".
{ config, lib, ... }:
let
  cfg = config.build.system.systemDefaults;
in
{
  options.build.system.systemDefaults = {
    enable = lib.mkOption {
      description = "Enable default values for basic options set system wide";
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    # We use flakes for our configurations, so channels are obsolete.
    nix.settings.experimental-features = lib.mkDefault "nix-command flakes";
    nix.channel.enable = lib.mkDefault false;

    # Delete old profiles and unreachable objects from the Nix store.
    # Does not delete the current generation of any profile.
    nix.gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "daily";
      options = lib.mkDefault "--delete-older-than 5d";
    };

    # Use the same instance of pkgs for NixOS and home-manager.
    home-manager.useGlobalPkgs = lib.mkDefault true;

    # Install packages to /etc/profiles instead of ~/.nix-profile.
    # Required for 'nixos-rebuild build-vm'.
    home-manager.useUserPackages = lib.mkDefault true;
  };
}
