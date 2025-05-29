{
  description = "Modular NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
    { ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      {
        # config, inputs, lib, options
        withSystem,
        ...
      }@top:
      {
        imports = [
          #inputs.home-manager.flakeModules.home-manager
          inputs.treefmt-nix.flakeModule
        ];
        systems = [ "x86_64-linux" ];
        perSystem =
          { ... }:
          {
            treefmt = {
              projectRootFile = "flake.nix";
              programs.nixfmt.enable = true;
              programs.nixfmt.strict = true;
            };
          };
        debug = true;
        flake = {
          #homeModules = [];
          #homeConfigurations = {};
          nixosConfigurations = {
            desknix = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                inputs.home-manager.nixosModules.home-manager # Move to top level imports if other than flakeModules are allowed
                inputs.vscode-server.nixosModules.default
                ./modules
                ./hosts/desknix
                ./systems/main
                ./users/mp
              ];
            };
            previousnix = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                inputs.home-manager.nixosModules.home-manager
                inputs.vscode-server.nixosModules.default
                ./modules
                ./hosts/previousnix
                ./systems/main
                ./users/mp
              ];
            };
            lapnix = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                inputs.home-manager.nixosModules.home-manager
                inputs.vscode-server.nixosModules.default
                ./modules
                ./hosts/lapnix
                ./systems/main
                ./users/mp
              ];
            };
            wsl = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                inputs.home-manager.nixosModules.home-manager
                inputs.nixos-wsl.nixosModules.wsl
                inputs.vscode-server.nixosModules.default # ?
                ./modules
                ./hosts/wsl
                ./systems/wsl
                ./users/wsl
                { wsl.defaultUser = "wsl"; }
              ];
            };
          };
        };
      }
    );
}
