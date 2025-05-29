# Configure basic Nix settings shared by all systems.
#
# This module can be imported by all system configs.
{ inputs, ... }:
let
  inherit (inputs.self.outputs) nixosModules overlays;
in
{
  imports = [
    nixosModules.unfree
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.overlays = [ overlays.nixpkgs-unstable ];

  nix = {
    # Our configurations use flakes ...
    settings.experimental-features = "nix-command flakes";
    # ... making channels obsolete.
    channel.enable = false;
    # Prefer to always use full flake URIs.
    registry = { };
    # Help nixd find modules.
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    # Delete old profiles and unreachable objects from the Nix store.
    # Does not delete the current generation of any profile.
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };

  home-manager = {
    # Use the same instance of pkgs for NixOS and home-manager.
    useGlobalPkgs = true;
    # Install packages to /etc/profiles instead of ~/.nix-profile.
    # Required for 'nixos-rebuild build-vm'.
    useUserPackages = true;
  };
}
