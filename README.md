<div align="center">

# NixOS-Config

**My NixOS configuration**

<p>
<img src="https://img.shields.io/badge/Slop-free-green?style=for-the-badge&logo=github"/>
</p>

</div>

This repository contains my NixOS configuration flake.
It configures all my machines, whether they're desktops, laptops, servers, or virtual; personal or for work.

> [!WARNING]
> This flake is only the public part of my configurations, and it won't build on its own.
> It's public to show off my configuration, not to be run by anyone else.
>
> To `nixos-rebuild` it standalone anyway, remove all `sops` attributes and add a `nixosConfigurations` output built with `lib.mkHost` (see [Usage](#usage)).

## Structure

- `checks`: Additional `nix flake check`s.
- `hosts`: One NixOS configuration per directory. A host enables profiles and users, and sets what is specific to that machine.
- `modules`: Features are implemented in modules. All modules are always imported, hosts and users enable what they want. `core` modules are always enabled.
- `overlays`: Changes to pkgs, accessible through `self.outputs.overlays`.
- `packages/initial-install`: Helper script to reinstall existing machines from scratch.
- `profiles`: Bundles of features, enabled by hosts and users.
- `users`: One user configuration per directory.

## Usage

This flake contains only the public part of my configurations.
It's almost complete; it just misses the `sops.defaultSopsFile` and key config.

There is also a secret flake, which contains the above mentioned attributes and all `sops` files.
It builds the hosts with `lib.mkHost` from this flake, adding the secrets config as one more module.
```nix
{
  description = "Private NixOS configurations";

  inputs = {
    nixos-config.url = "github:mikkopitkanen222/nixos-config";
    #nixos-config.url = "git+file:///path/to/public/nixos-config";
    nixpkgs.follows = "nixos-config/nixpkgs";
  };

  outputs =
    {
      self,
      nixos-config,
      nixpkgs,
      ...
    }:
    nixos-config
    // {
      nixosConfigurations = nixpkgs.lib.genAttrs nixos-config.lib.hostNames (
        name:
        nixos-config.lib.mkHost name [
          {
            sops = {
              defaultSopsFile = "${self}/${name}.yaml";
              age = {
                generateKey = false;
                sshKeyPaths = [ ];
              };
              gnupg = {
                home = "/var/lib/sops";
                sshKeyPaths = [ ];
              };
            };

            # nh builds from this repo.
            programs.nh.flake = "/path/to/private/flake/outside/store";

            # `nixos-version --configuration-revision`:
            # this repo's commit, then the public repo's.
            system.configurationRevision = "${self.dirtyRev or self.rev} ${
              nixos-config.dirtyRev or nixos-config.rev
            }";
          }
        ]
      );
    };
}
```

Update process for a two-flake setup:

1. Commit all changes in the public repo, and push them, unless the private flake uses a `git+file://` URL.
2. Run `nix flake update` in the private repo.
3. Build, and boot into the new configuration: `nh os boot && reboot`.
