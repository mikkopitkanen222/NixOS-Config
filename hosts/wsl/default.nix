{ pkgs, ... }: {
  mp222 = {
    profiles = {
      work.enable = true;
      wsl.enable = true;
    };
    users.mp.enable = true;
  };
  wsl.defaultUser = "mp";

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = [ pkgs.tree ];

  system.stateVersion = "25.05";
}
