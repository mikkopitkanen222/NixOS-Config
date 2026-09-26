{ config, inputs, ... }: {
  options.mp222.core = {
    #
  };

  config = {
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

    environment.shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "l" = "ls -aFhl";
    };

    # Get the commit this system was built from: nixos-version --configuration-revision
    system.configurationRevision = "${inputs.self.rev or inputs.self.dirtyRev}";
  };
}
