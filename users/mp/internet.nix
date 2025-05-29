# Configure browser, password manager, and VPN.
#
# This module can be imported by user "mp" config.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    proton-pass
    protonvpn-gui
  ];

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
      "elicpjhcidhpjomhibiffojpinpmmpil" # Video Downloader
    ];
  };
}
