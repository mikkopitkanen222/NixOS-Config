{ config, inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  nix = {
    # The system config makes use of modern flakes, disabling old channels.
    settings.experimental-features = "nix-command flakes";
    channel.enable = false;

    # Help nixd find modules.
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  programs.nh = {
    enable = true;
    flake = "${config.users.users.mp.home}/nixos-config";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 7d";
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

  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "l" = "ls -aFhl";
  };

  # Get the commit this system was built from: nixos-version --configuration-revision
  system.configurationRevision = "${inputs.self.rev or inputs.self.dirtyRev}";
}
