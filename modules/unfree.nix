# Allow installing only specific unfree software packages.
# https://nixos.org/manual/nixpkgs/unstable/#sec-allow-unfree.
{
  config,
  lib,
  ...
}:
let
  cfg = config.unfree;
in
{
  options.unfree = {
    allowedPackages = lib.mkOption {
      description = ''
        By default, Nix disallows installing packages with unfree licenses.
        Option 'nixpkgs.config.allowUnfree' allows all unfree software.
        Without it, this option allows only the named packages in this option.
      '';
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "nvidia-x11" ];
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) cfg.allowedPackages;
  };
}
