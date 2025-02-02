# Enable Steam.
{ ... }:
{
  imports = [
    ../../modules/unfree.nix
  ];

  unfree.allowedPackages = [
    "steam"
    "steam-unwrapped"
  ];

  programs.steam.enable = true;
}
