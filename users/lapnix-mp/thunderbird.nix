{ ... }:
{
  home-manager.users.mp = {
    programs.thunderbird = {
      enable = true;
      profiles.mp = {
        isDefault = true;
      };
    };
  };
}
