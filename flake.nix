# nixos-config/flake.nix
# Define the configuration flake.
{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-secrets = {
      url = "git+ssh://git@github.com/mikkopitkanen222/nixos-secrets.git?shallow=1";
      flake = false;
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/hyprland";
    # Don't touch hyprland.inputs, see https://wiki.hyprland.org/Nix/Cachix/.
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-manager.url = "github:viperML/wrapper-manager";
  };

  outputs =
    inputs:
    let
      systems = [ "x86_64-linux" ];
      eachSystem =
        fn:
        inputs.nixpkgs.lib.genAttrs systems (
          system: fn inputs.nixpkgs.legacyPackages.${system}
        );
      treefmtEval = eachSystem (
        pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );

      makeConfig =
        {
          host,
          system,
          users,
          extraModules ? [ ],
        }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            (./. + "/hosts/${host}")
            (./. + "/systems/${host}-${system}")
          ]
          ++ (inputs.nixpkgs.lib.map (user: ./. + "/users/${host}-${user}") users)
          ++ extraModules;
        };
    in
    {
      # > nix fmt
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      # > nix flake check
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check inputs.self;
      });

      # Modules and overlays used in configurations.
      nixosModules = import ./modules { inherit inputs; };
      overlays = import ./overlays { inherit inputs; };

      # > nixos-rebuild ...
      nixosConfigurations = {
        desknix = makeConfig {
          host = "desknix";
          system = "daily";
          users = [ "mp" ];
        };

        lapnix = makeConfig {
          host = "lapnix";
          system = "daily";
          users = [ "mp" ];
        };

        wsl = makeConfig {
          host = "wsl";
          system = "work";
          users = [ "mp" ];
          extraModules = [ { wsl.defaultUser = "mp"; } ];
        };
      };
    };
}
