{
  # Timezone can be set temporarily with `timedatectl set-timezone <tz-name>`.
  services.automatic-timezoned.enable = true;

  # Local format is correct for most things, except for messages and numerics:
  # - Translation is a lossy process and non-english interfaces are cringe.
  # - Finnish number formatting correctly uses a narrow space as the thousands
  #   separator. However, we use the retarded decimal comma. Americans use the
  #   sensible decimal point, but have sadly adopted a cluttery comma as the
  #   thousands separator. Mexicans seem to have this figured the fuck out.
  i18n = {
    defaultLocale = "fi_FI.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_NUMERIC = "es_MX.UTF-8";
    };
  };

  # Use the `services.xserver.xkb` config in tty.
  console.useXkbConfig = true;

  # Users set these in Hyprland anyway, but set a global fallback just in case.
  services.xserver.xkb = {
    layout = "fi";
    model = "pc105";
    variant = "winkeys";
  };
}
