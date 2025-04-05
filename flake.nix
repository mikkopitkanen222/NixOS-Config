{
  description = "Modular NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    { nixpkgs, ... }@inputs:
    let
      makeSystem =
        system: syscfg:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-wsl.nixosModules.wsl
            inputs.vscode-server.nixosModules.default
            ./hosts
            ./systems
            ./users
            syscfg
          ];
        };
    in
    {
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      };

      nixosConfigurations = {
        desknix = makeSystem "x86_64-linux" {
          system.hostName = "desknix";
          system.systemName = "main";
          system.userNames = [ "mp" ];
        };

        previousnix = makeSystem "x86_64-linux" {
          system.hostName = "previousnix";
          system.systemName = "main";
          system.userNames = [ "mp" ];
        };

        lapnix = makeSystem "x86_64-linux" {
          system.hostName = "lapnix";
          system.systemName = "main";
          system.userNames = [ "mp" ];
        };

        wsl = makeSystem "x86_64-linux" {
          system.hostName = "wsl";
          system.systemName = "wsl";
          system.userNames = [ "wsl" ];
        };
      };
    };
}
