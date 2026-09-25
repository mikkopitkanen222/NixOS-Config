<div align="center">

# NixOS-Config

**My NixOS configuration**

<p>
<img alt="The purest slop, AI-free forever" src="https://img.shields.io/badge/Hacked-together-green?style=for-the-badge&logo=github"/>
</p>

</div>

This repository contains my NixOS configuration flake.
I use it to configure multiple machines of mine.
Each host supports multiple users, but currently only one is used.

> [!WARNING]
> This flake contains only the public part of my configurations.
> It will not build on its own.
> This flake is only made public so it may serve as a simple example of a working configuration.
>
> To `nixos-rebuild` this flake standalone, remove all `sops` attributes.
> At the time of writing that should be enough. See [Usage](#usage).
> (Not that anyone should do that, for the reason stated above.)

## Structure

- `modules`: Reusable modules, shareable between hosts (placeholder)
- `overlays`: Reusable overlays, shareable between hosts
- `packages/initial-install`: Helper script to reinstall existing configs from scratch
- `systems/<host>`: System configurations organized by host.
  - `users/<user>`: User configurations organized by user

System configurations reuse configs from other systems.
`desknix` has the main system configuration and other systems import configs from that, adding and `mkForce`ing things as needed.

> [!INFO]
> Improving this structure is a work in progress.

## Usage

This flake contains only the public part of my configurations.
It's almost complete; it just misses the `sops.defaultSopsFile` and key config.

There is also a secret flake, which contains the above mentioned attributes and all `sops` files.
It has a flake like this:

```nix
{
  description = "Private NixOS configurations";

  inputs.nixos-config.url = "github:mikkopitkanen222/nixos-config";
  #inputs.nixos-config.url = "git+file:///path/to/public/nixos-config";

  outputs =
    { self, nixos-config, ... }:
    nixos-config
    // {
      nixosConfigurations = builtins.mapAttrs (
        name: value:
        value.extendModules {
          modules = [
            ({ config, lib, ... }: {
              sops = {
                defaultSopsFile = "${self}/${name}.yaml";
                age = {
                  generateKey = false;
                  sshKeyPaths = [ ];
                };
                gnupg = {
                  home = "/path/to/sops/server/key";
                  sshKeyPaths = [ ];
                };
              };

              # Already defined in nixos-config; override to this secrets flake, instead.
              programs.nh.flake = lib.mkForce "/path/to/this/repo/outside/store";

              # Get the commit this system was built from: nixos-version --configuration-revision
              # Already defined in nixos-config; override to this secrets flake, instead.
              system.configurationRevision = lib.mkForce "${self.dirtyRev or self.rev}";
            })
          ];
        }
      ) nixos-config.nixosConfigurations;
    };
}
```

Update process for a two-flake setup:

- Commit (and push, if not using `git+file://` url) all changes in the public repo
- `nix flake update` in the private repo
- `nh os boot && reboot`
