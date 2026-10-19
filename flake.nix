{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/x86_64-linux";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
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
        pkgs: _: treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );
    in
    {
      packages = eachSystem (
        pkgs: _: { initial-install = pkgs.callPackage ./packages/initial-install { }; }
      );

      apps = eachSystem (
        _: system: {
          install = {
            type = "app";
            program = "${self.packages.${system}.initial-install}/bin/install.sh";
          };
        }
      );

      formatter = eachSystem (_: system: treefmtEval.${system}.config.build.wrapper);

      checks = eachSystem (
        pkgs: system:
        {
          formatting = treefmtEval.${system}.config.build.check self;
        }
        // import ./checks/hosts.nix { inherit pkgs self; }
      );

      devShells = eachSystem (
        _: system: { default = treefmtEval.${system}.config.build.devShell; }
      );

      overlays = import ./overlays { inherit inputs; };

      lib =
        let
          inherit (nixpkgs) lib;

          subdirsIn =
            dir:
            lib.pipe dir [
              builtins.readDir
              (lib.filterAttrs (_: type: type == "directory"))
              lib.attrNames
            ];

          nixFilesIn =
            dirs:
            lib.pipe dirs [
              (map lib.filesystem.listFilesRecursive)
              lib.flatten
              (lib.filter (lib.hasSuffix ".nix"))
            ];

          hostNames = subdirsIn ./hosts;
          userNames = subdirsIn ./users;

          systemModules = nixFilesIn [
            ./modules/system
            ./profiles/system
          ];
          userModules = nixFilesIn [
            ./modules/user
            ./profiles/user
          ];
        in
        {
          inherit hostNames;

          mkHost =
            host: extraModules:
            lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules =
                systemModules
                ++ (map (name: ./users/${name}) userNames)
                ++ [
                  ./hosts/${host}
                  {
                    networking.hostName = lib.mkDefault host;
                    home-manager.sharedModules = userModules;
                  }
                ]
                ++ extraModules;
            };
        };
    };
}
