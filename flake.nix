{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-secrets = {
      url = "git+ssh://git@github.com/mikkopitkanen222/nixos-secrets.git?shallow=1";
      flake = false;
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:avengemedia/dankmaterialshell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dgop = {
      url = "github:avengemedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      self,
      nixpkgs,
      systems,
      treefmt-nix,
      ...
    }@inputs:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system: f nixpkgs.legacyPackages.${system} system
        );
      treefmtEval = eachSystem (
        pkgs: system: treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );
    in
    {
      formatter = eachSystem (
        pkgs: system: treefmtEval.${system}.config.build.wrapper
      );

      checks = eachSystem (
        pkgs: system: { formatting = treefmtEval.${system}.config.build.check self; }
      );

      packages = eachSystem (
        pkgs: system: {
          initial-install = pkgs.callPackage ./packages/initial-install { };
        }
      );

      apps = eachSystem (
        pkgs: system:
        let
          inherit (self.packages.${system}) initial-install;
        in
        {
          default = self.apps.${system}.install;
          install = {
            type = "app";
            program = "${initial-install}/bin/install.sh";
          };
        }
      );

      # Modules and overlays used in configurations.
      nixosModules = import ./modules { inherit inputs; };
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        desknix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/desknix ];
        };

        lapnix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/lapnix ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/wsl ];
        };
      };
    };
}
