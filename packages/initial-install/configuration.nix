# This file is a modified version of the generated initial configuration.
# It will be used only as the initial configuration when installing NixOS.
# After the first boot the actual config is installed. (The installation
# always froze when I tried to nixos-install my full configuration.)
{ lib, pkgs, ... }:
{
  imports = [
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./disko.nix
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos0";
    networkmanager.enable = true;
  };

  nix = {
    settings.experimental-features = "nix-command flakes";
    channel.enable = false;
  };
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = lib.mkForce "fi";
    useXkbConfig = true;
  };

  services.getty = {
    autologinUser = "root";
    autologinOnce = true;
  };

  environment.systemPackages = with pkgs; [
    git
    tree
  ];

  system.stateVersion = "25.11";
}
