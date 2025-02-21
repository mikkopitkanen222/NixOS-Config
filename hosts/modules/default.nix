# Import host modules.
{
  ...
}:
{
  imports = [
    ./cpu-amd.nix
    ./cpu-intel.nix
    ./fprint.nix
    ./gpu-nvidia.nix
  ];
}
