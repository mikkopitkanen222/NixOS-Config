# Lenovo Ideapad fingerprint reader driver.
{ pkgs, ... }:
{
  imports = [
    ../../modules/unfree.nix
  ];

  unfree.allowedPackages = [
    "libfprint-2-tod1-elan"
  ];

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-elan;
    };
  };
}
