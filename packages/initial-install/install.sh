#! /usr/bin/env bash
#
# This script semi-automates the installation of one of the NixOS configurations
# in this repo on a new machine.

set -euo pipefail

readonly SCRIPT_DIR="$(dirname "$0")"

system=
step=0
dry_run=

# Print the help text to stdout.
showUsage() {
  cat <<EOF
Usage:
  nix run .#install -- [options]

Options:
  --system <system>   Name of system whose disk configuration shall be installed.
                      The filepath systems/\$system/disko.nix must point to an
                      existing file in this repository. Required on step 0.
  --step <step>       Installation step to be performed. Number in range 0-2.
                      Steps must be run in order. Defaults to 0.
  -d | --dry-run      Show what commands would be run, but don't run anything.
  -h | --help         Show this message and exit.
EOF
}

# Print an error message to stderr and the help text to stdout, and exit.
badUsage() {
  local NC
  local RED
  readonly NC='\033[0m'
  readonly RED='\033[0;31m'

  echo -e "${RED}$1${NC}" >&2
  showUsage
  exit 1
}

# Parse options from command-line arguments into global variables.
parseArgs() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
    --system)
      if [[ $# -lt 2 ]]; then
        echo "Option $1 requires an argument" >&2
        exit 1
      fi
      system=$2
      shift
      ;;
    --step)
      if [[ $# -lt 2 ]]; then
        echo "Option $1 requires an argument" >&2
        exit 1
      fi
      step=$2
      shift
      ;;
    -d | --dry-run)
      dry_run=1
      ;;
    -h | --help)
      showUsage
      exit 0
      ;;
    *)
      badUsage "Unknown option: $1"
      ;;
    esac
    shift
  done
}

# Execute a command or print it to stdout on dry runs.
maybeRun() {
  if [[ -z ${dry_run-} ]]; then
    "$@"
  else
    echo "Would run: $*"
  fi
}

# Prompt the user whether the script should continue or exit.
# Increments step when continuing.
# Prints continuation instructions to stdout when exiting.
continueOrExit() {
  local do_continue
  read -p "$1 [y/n]: " do_continue
  if [[ "${do_continue,,}" == "y" ]]; then
    ((step+=1))
  else
    echo "When ready to continue, run 'nix run .#install -- --step $((step+1))'."
    exit 0
  fi
}

# Generate the system's initial configuration.
step0() {
  if [[ -z ${system-} ]]; then
    badUsage "Missing system option"
  fi

  echo "Generating initial configuration for system $system..."
  maybeRun cp "$SCRIPT_DIR/../share/configuration.nix" /tmp
  maybeRun cp "$SCRIPT_DIR/../share/$system"/*.nix /tmp
  maybeRun cp "$SCRIPT_DIR/first-boot.sh" /tmp
  maybeRun chmod 644 /tmp/*.nix
  maybeRun chmod 644 /tmp/first-boot.sh
  cat <<EOF
Copied files to /tmp:
- configuration.nix: Initial barebones configuration. Used only for first boot.
- disko.nix: Disk configuration specific to this machine.
- hardware-configuration.nix: Hardware configuration specific to this machine.
- first-boot.sh: Script run on first boot that installs the full configuration.

Adjust these files in /tmp now, if necessary.
For example, if this is a new machine, you might want to check the devices in disko.nix.
EOF
  continueOrExit "Continue to format your disks without editing /tmp/disko.nix?"
}

# Partition, format, and mount the disks.
step1() {
  echo "Running disko..."
  maybeRun sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko.nix
  cat <<EOF
Your disks have now been partitioned, formatted, and mounted. Filesystems have
been created, and if your disko.nix configured any encrypted partitions, you
should have been prompted for enrollment of decryption tokens.

You may now do final tweaks to your disks, filesystems, and files in /tmp.
EOF
  continueOrExit "Continue to install NixOS without further tweaks?"
}

# Install the initial configuration.
step2() {
  echo "Installing NixOS..."
  maybeRun sudo mkdir -p /mnt/etc/nixos
  maybeRun sudo cp /tmp/*.nix /mnt/etc/nixos
  maybeRun sudo cp /tmp/first-boot.sh /mnt/etc/nixos
  maybeRun sudo chmod 755 /mnt/etc/nixos/first-boot.sh
  maybeRun sudo nixos-install -j auto
  cat <<EOF
NixOS has now been installed.
When ready to continue, run 'reboot'.
After rebooting: log in as root, run /etc/nixos/first-boot.sh, reboot
EOF
  exit 0
}

main() {
  parseArgs "$@"

  [[ $step -eq 0 ]] && step0
  [[ $step -eq 1 ]] && step1
  [[ $step -eq 2 ]] && step2

  badUsage "Unknown step $step"
}

main "$@"
