# Overlay packages from branch nixpkgs-unstable to pkgs.unstable.
{ inputs, ... }: final: prev: { unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system}; }
