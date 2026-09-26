{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  wsl = {
    enable = true;
    defaultUser = (lib.head config.mp222.host.users).name;
  };

  environment.systemPackages = [ pkgs.wget ];
}
