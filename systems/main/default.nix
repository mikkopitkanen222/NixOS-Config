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
    ../modules/sc-crypto.nix
    ../modules/sddm.nix
    ../modules/steam.nix
  ];

  systemDefaults.enable = true;
  scCrypto.enable = true;

  environment.systemPackages = with pkgs; [
    tree
  ];
}
