{
  description = "Modular NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      };

      nixosConfigurations = {
        placeholder = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./overlays/nixpkgs-unstable.nix
          ];
        };
      };
    };
}
