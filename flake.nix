{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      systems,
      treefmt-nix,
      ...
    }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

      treefmtEval = eachSystem (
        pkgs:
        treefmt-nix.lib.evalModule pkgs {
          projectRootFile = ".git/config";
          programs.nixfmt.enable = true;
          programs.nixfmt.strict = true;
        }
      );
    in
    {
      # > nix fmt
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      # Modules and overlays used in configurations.
      nixosModules = import ./modules { inherit inputs; };
      overlays = import ./overlays { inherit inputs; };

      # > nixos-rebuild ...
      nixosConfigurations = {
        desknix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desknix
            ./systems/main
            ./users/mp
          ];
        };

        previousnix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/previousnix
            ./systems/main
            ./users/mp
          ];
        };

        lapnix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/lapnix
            ./systems/main
            ./users/mp
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/wsl
            ./systems/wsl
            ./users/wsl
            { wsl.defaultUser = "wsl"; }
          ];
        };
      };
    };
}
