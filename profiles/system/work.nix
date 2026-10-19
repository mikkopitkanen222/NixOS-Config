{ lib, ... }: {
  options.mp222.profiles.work = {
    enable = lib.mkEnableOption "the work system profile";
  };
}
