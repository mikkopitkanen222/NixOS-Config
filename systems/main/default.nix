# Main system configuration.
{
  pkgs,
  ...
}:
{
  imports = [
    ../modules/system-defaults.nix

    ../modules/audio.nix
    ../modules/locale.nix
    ../modules/openssh.nix
    ../modules/plasma.nix
    ../modules/sddm.nix
  ];

  systemDefaults.enable = true;

  environment.systemPackages = with pkgs; [
    tree
  ];
}
