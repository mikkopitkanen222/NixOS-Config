# Import host modules.
{ ... }:
{
  imports = [
    ./cpu-amd.nix
    ./cpu-intel.nix
    ./cpu.nix
    ./fprint.nix
    ./gpu-amd.nix
    ./gpu-nvidia.nix
    ./gpu.nix
  ];
}
