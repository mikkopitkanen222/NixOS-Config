{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

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

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    # Use the same instance of `pkgs` for NixOS and Home Manager.
    useGlobalPkgs = true;

    # Install packages to /etc/profiles instead of ~/.nix-profile.
    # Required for 'nixos-rebuild build-vm'.
    useUserPackages = true;
  };

  # Deterministic, declarative user configuration.
  users.mutableUsers = false;
}
