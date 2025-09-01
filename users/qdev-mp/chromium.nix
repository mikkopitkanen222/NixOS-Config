# nixos-config/users/qdev-mp/chromium.nix
# Configure Chromium browser for user 'mp' on host 'qdev'.
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "ghkdkllgoehcklnpajjjmfoaokabfdfm" # Remove Paywalls
      ];
    };
  };
}
