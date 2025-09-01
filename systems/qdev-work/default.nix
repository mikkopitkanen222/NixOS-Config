# nixos-config/systems/qdev-work/default.nix
# Configure system 'work' on host 'qdev'.
{ inputs, pkgs, ... }:
{
  nix = {
    # The system config makes use of modern flakes, disabling old channels.
    settings.experimental-features = "nix-command flakes";
    channel.enable = false;

    # Help nixd find modules.
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    # Delete old profiles and unreachable objects from the Nix store.
    # Does not delete the current generation of any profile.
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  home-manager = {
    # Use the same instance of pkgs for NixOS and Home Manager.
    useGlobalPkgs = true;

    # Install packages to /etc/profiles instead of ~/.nix-profile.
    # Required for 'nixos-rebuild build-vm'.
    useUserPackages = true;
  };

  # Deterministic, declarative user configuration.
  users.mutableUsers = false;

  # Lone packages without further config are installed here:
  environment.systemPackages = with pkgs; [ tree ];

  nixpkgs = {
    config.allowUnfree = true;
    # Overlays output by our flake are enabled here:
    overlays = [ ];
  };

  imports = [
    # Modules from our own and 3rd parties' flakes are imported here:
    inputs.home-manager.nixosModules.home-manager

    # Packages requiring config are installed in modules imported here:
    ./iwgtk.nix
    ./locale.nix
    ./overskride.nix
    ./pipewire.nix
    ./security.nix
    ./smartcard-crypto.nix
    ./sops.nix
  ];

  virtualisation.podman.enable = true;
}
