{
  imports = [ ../../profiles/wsl.nix ];

  networking.hostName = "wsl";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  mp222.host.users = [
    {
      name = "mp";
      extraGroups = [ "wheel" ];
    }
  ];
}
