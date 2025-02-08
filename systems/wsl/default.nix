# Wsl system configuration.
{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.vscode-server.nixosModules.default
    ../modules/system-defaults.nix
    ../modules/locale.nix
    ../modules/sc-crypto.nix
  ];

  services.vscode-server.enable = true;

  systemDefaults.enable = true;
  scCrypto.enable = true;

  environment.systemPackages = with pkgs; [
    tree
  ];
}
