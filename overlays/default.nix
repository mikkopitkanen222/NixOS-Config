{ inputs, ... }@args:
{
  nixpkgs-unstable = import ./nixpkgs-unstable.nix args;
}
