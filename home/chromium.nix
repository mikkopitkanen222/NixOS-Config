{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mp222.chromium;
in
{
  options.mp222.chromium = {
    enable = lib.mkEnableOption "chromium";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = lib.mkDefault pkgs.brave;
      extensions = lib.mkDefault [
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
      commandLineArgs = lib.mkDefault [
        "--disable-features=WaylandWpColorManagerV1"
      ];
    };
  };
}
