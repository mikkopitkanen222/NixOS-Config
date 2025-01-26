# Main system configuration.
{
  pkgs,
  ...
}:
{
  imports = [
    ../modules/system-defaults.nix
  ];

  systemDefaults.enable = true;

  environment.systemPackages = with pkgs; [
    tree
  ];
}
