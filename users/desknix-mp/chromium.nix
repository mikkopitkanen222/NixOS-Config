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
        "ghkdkllgoehcklnpajjjmfoaokabfdfm" # Remove Paywalls
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
        "ajopnjidmegmdimjlfnijceegpefgped" # BetterTTV
        "mmioliijnhnoblpgimnlajmefafdfilb" # Shazam
        "jdocbkpgdakpekjlhemmfcncgdjeiika" # Absolute Enable Right Click
      ];
    };
  };
}
