# Main system configuration.
{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.vscode-server.nixosModules.default
    ../modules/system-defaults.nix
    ../modules/audio.nix
    ../modules/locale.nix
    ../modules/openssh.nix
    ../modules/plasma.nix
    ../modules/sc-crypto.nix
    ../modules/sddm.nix
    ../modules/steam.nix
  ];

  services.vscode-server.enable = true;

  systemDefaults.enable = true;
  scCrypto.enable = true;

  environment.systemPackages = with pkgs; [
    tree
  ];
}
