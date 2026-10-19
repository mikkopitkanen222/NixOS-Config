{ inputs, lib, ... }: {
  nix = {
    # Channels are dirty, impure even.
    channel.enable = false;
    settings = {
      # The default 1 MiB buffer stalls downloads with "buffer full".
      download-buffer-size = 128 * 1024 * 1024;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # Make <nixpkgs> point to the nixpkgs (in store) this system was built from.
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.self.outputs.overlays.nixpkgs-unstable
      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = lib.mkDefault "weekly";
      extraArgs = lib.mkDefault "--keep-since 14d";
    };
  };

  # Built system's source revision: `nixos-version --configuration-revision`.
  system.configurationRevision = lib.mkDefault (
    inputs.self.dirtyRev or inputs.self.rev
  );
}
