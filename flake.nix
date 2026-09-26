{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    systems.url = "github:nix-systems/x86_64-linux";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    dms = {
      url = "github:avengemedia/dankmaterialshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dank-search = {
      url = "github:avengemedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
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
        pkgs: _system: treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );
    in
    {
      formatter = eachSystem (
        _pkgs: system: treefmtEval.${system}.config.build.wrapper
      );

      checks = eachSystem (
        _pkgs: system: { formatting = treefmtEval.${system}.config.build.check self; }
      );

      packages = eachSystem (
        pkgs: _system: {
          initial-install = pkgs.callPackage ./packages/initial-install { };
        }
      );

      apps = eachSystem (
        _pkgs: system: {
          install = {
            type = "app";
            program = "${self.packages.${system}.initial-install}/bin/install.sh";
          };
        }
      );

      devShells = eachSystem (
        pkgs: system: {
          default = self.devShells.${system}.checks;
          checks = pkgs.mkShellNoCC {
            inputsFrom = [ self.checks.${system}.formatting ];
          };
        }
      );

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
          modules = [ ./hosts/wsl ];
        };

        qdev = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/qdev ];
        };
      };
    };
}
