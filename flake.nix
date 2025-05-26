{
  description = "Modular NixOS configurations";

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

      makeSystem =
        system: buildConfig:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-wsl.nixosModules.wsl
            inputs.vscode-server.nixosModules.default
            ./hosts
            ./modules
            ./overlays
            ./systems
            ./users
            buildConfig
          ];
        };
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      nixosConfigurations = {
        desknix = makeSystem "x86_64-linux" {
          build.hostName = "desknix";
          build.systemName = "main";
          build.userNames = [ "mp" ];
        };

        previousnix = makeSystem "x86_64-linux" {
          build.hostName = "previousnix";
          build.systemName = "main";
          build.userNames = [ "mp" ];
        };

        lapnix = makeSystem "x86_64-linux" {
          build.hostName = "lapnix";
          build.systemName = "main";
          build.userNames = [ "mp" ];
        };

        wsl = makeSystem "x86_64-linux" {
          build.hostName = "wsl";
          build.systemName = "wsl";
          build.userNames = [ "wsl" ];
        };
      };
    };
}
