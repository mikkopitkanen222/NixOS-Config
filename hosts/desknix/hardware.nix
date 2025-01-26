# Desknix hardware configuration.
{ ... }:
{
  imports = [
    ../modules/cpu-intel.nix
    ../modules/gpu-nvidia.nix
  ];

  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "usbhid"
  ];
}
