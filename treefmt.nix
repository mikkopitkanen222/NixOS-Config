# nixos-config/treefmt.nix
# Configure formatter options.
{ ... }:
{
  projectRootFile = "flake.nix";
  programs.nixfmt = {
    enable = true;
    strict = true;
    width = 80;
  };
}
