# User specific browser config.
{ pkgs, ... }:
{
  home-manager.users.mp = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
        "inomeogfingihgjfjlpeplalcfajhgai" # Chrome Remote Desktop

        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        "jdocbkpgdakpekjlhemmfcncgdjeiika" # Absolute Enable Right Click

        "ammjkodgmmoknidbanneddgankgfejfh" # 7TV
        "ajopnjidmegmdimjlfnijceegpefgped" # BetterTTV
        "mmioliijnhnoblpgimnlajmefafdfilb" # Shazam

        "baajncdfffcpahjjmhhnhflmbelpbpli" # Video Downloader
      ];
    };
  };
}
