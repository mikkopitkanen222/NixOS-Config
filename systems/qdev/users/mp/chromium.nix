# https://github.com/aristocratos/btop
{ ... }:
{
  imports = [ ../../../desknix/users/mp/chromium.nix ];

  home-manager.users.mp.programs.chromium = {
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1Password
    ];
  };
}
