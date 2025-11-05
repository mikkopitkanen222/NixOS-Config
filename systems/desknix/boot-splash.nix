{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = "glitch";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "glitch" ]; })
      ];
    };

    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    consoleLogLevel = 4;

    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
