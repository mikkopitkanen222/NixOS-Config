{ ... }:
{
  disko.devices.disk = {
    "boot-drive" = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-SAMSUNG_MZAL8512HDLU-00BL2_S77MNF0X294157";
      postCreateHook = ''
        enrollFidoTokens() {
          local answer
          echo "Ready to enroll FIDO2 tokens?"
          while true; do
            read -p "Plug in a token and enter 'y' to enroll it. Enter 'n' to continue without enrolling tokens. [y/n]: " answer
            if [[ "''${answer,,}" == "y" ]]; then
              systemd-cryptenroll /dev/disk/by-partlabel/luks --fido2-device=auto --fido2-credential-algorithm=eddsa
              echo "Enroll another token?"
            elif [[ "''${answer,,}" == "n" ]]; then
              break
            else
              echo "Twas a simple question: 'y' or 'n'?"
            fi
          done
        }
        enrollFidoTokens
      '';
      content = {
        type = "gpt";
        partitions = {
          "ESP" = {
            priority = 1;
            type = "EF00";
            label = "uefi";
            size = "1G";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
            };
          };
          "crypted" = {
            priority = 2;
            label = "luks";
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraFormatArgs = [
                "--cipher=aes-xts-plain64"
                "--key-size=512"
                "--hash=sha512"
              ];
              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
                crypttabExtraOpts = [
                  "fido2-device=auto"
                  "token-timeout=10"
                ];
              };
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "nixos"
                  "-f"
                ];
                subvolumes = {
                  "/swap" = {
                    mountpoint = "/.swap";
                    swap.swapfile.size = "8G";
                  };
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
