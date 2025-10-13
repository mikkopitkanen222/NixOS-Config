{ ... }:
{
  projectRootFile = "flake.nix";
  programs.nixfmt = {
    enable = true;
    strict = true;
    width = 80;
  };
}
