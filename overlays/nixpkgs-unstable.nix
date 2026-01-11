{ inputs, ... }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (final) config;
    localSystem = final.stdenv.hostPlatform;
  };
}
