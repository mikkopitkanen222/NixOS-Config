# nixos-config/users/lapnix-mp/chromium.nix
# Configure Chromium browser for user 'mp' on host 'lapnix'.
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
        "ajopnjidmegmdimjlfnijceegpefgped" # BetterTTV
        "mmioliijnhnoblpgimnlajmefafdfilb" # Shazam
        "jdocbkpgdakpekjlhemmfcncgdjeiika" # Absolute Enable Right Click
      ];
    };
  };
}
