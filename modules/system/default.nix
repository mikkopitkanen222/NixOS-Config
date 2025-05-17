# Import system modules.
{ ... }:
{
  imports = [
    ./audio.nix
    ./factorio.nix
    ./locale.nix
    ./openssh.nix
    ./pam.nix
    ./plasma.nix
    ./sc-crypto.nix
    ./sddm.nix
    ./steam.nix
    ./system-defaults.nix
  ];
}
