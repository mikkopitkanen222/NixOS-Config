{ pkgs, ... }: {
  imports = [ ../../home ];
  mp222 = {
    btop = {
      enable = true;
      rocmSupport = true;
    };
    chromium.enable = true;
    clipse.enable = true;
  };
  programs.home-manager.enable = true;
  home = {
    username = "mp";
    homeDirectory = "/home/mp";
    stateVersion = "25.05";
    packages = with pkgs; [
      # Downtime
      bolt-launcher
      bs-manager
      pcsx2
      spotify
      # Image, Music & Video Viewers
      qimgv
      vlc
      # Messengers
      # Disable whatsie, as it depends on qt webengine 5.15, which is insecure and fails config eval.
      # Wait until whatsie migrates to qt webengine 6, or look for alternatives.
      # whatsie
      # Work
      nixd
      qalculate-qt
    ];
  };
}
