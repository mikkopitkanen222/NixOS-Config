{ lib, ... }: {
  programs.steam.enable = true;
  mp222.factorio.enable = lib.mkDefault true;
}
