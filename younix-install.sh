#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Installer dependencies
# -----------------------------------------------------------------------------

if [[ -z "${YOUNIX_INSTALLER_ENV:-}" ]]; then
    export YOUNIX_INSTALLER_ENV=1
    exec nix-shell -p git xdg-user-dirs --run "$0"
fi

if [[ "${EUID}" -eq 0 ]]; then
    echo "Do not run younix-install.sh as root."
    exit 1
fi

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

# ----------------------------------- Set installation mode

if [[ "$(findmnt -n -o FSTYPE /)" == "tmpfs" ]]; then
    installation_mode="iso"
else
    installation_mode="system"
fi

# -------------------------------------- Print phase header

print_header() {
    cat <<EOF

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

YouNIX Installation ($1 / 9)

Phase $1: $2

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

EOF
}

###############################################################################
#                                                                             #
#                             INSTALLATION SCRIPT                             #
#                                                                             #
###############################################################################
#  Phase 1: Get system information
#  Phase 2: Get user configuration
#  Phase 3: Print configuration summary
#  Phase 4: Create local repository
#  Phase 5: Prepare local repository
#  Phase 6: YouNIX Installation
#  Phase 7: Finish installation

# -----------------------------------------------------------------------------
# Phase 1: Get system information
# -----------------------------------------------------------------------------

clear

print_header 1 "Get system information"

state_version=""
arch=""
hostname=""
username=""
timezone=""
locale=""
keyboard_layout=""
keyboard_variant=""

echo
echo "Reading system information..."
echo

sleep 1

# -------------------------------------------- Architecture
arch="$(nix-instantiate --eval --expr 'builtins.currentSystem' 2>/dev/null | tr -d '"')"

# ------------------------------------------------ Hostname
hostname="$(hostnamectl --static)"

# ------------------------------------------------ Username
username="${USER}"

# ------------------------------------------------ Timezone
timezone="$(timedatectl show --property=Timezone --value)"

# -------------------------------------------------- Locale
locale="$(localectl status --no-pager | sed -n 's/^ *System Locale: *LANG=\(.*\)$/\1/p')"

# ------------------------------------------------ Keyboard
keyboard_layout="$(localectl status --no-pager | sed -n 's/^ *X11 Layout: *//p')"
keyboard_variant="$(localectl status --no-pager | sed -n 's/^ *X11 Variant: *//p')"

# ------------------------------------------- State version
state_version="$(
    nixos-option system.stateVersion |
        awk '/^Value:$/ {
      getline
      gsub(/^[[:space:]]+|[[:space:]]+$/, "")
      gsub(/^"|"$/, "")
      print
      exit
    }'
)"

clear

echo
echo "Please enter the correct values. Press ENTER to accept proposal."
echo

# State version
read -r -p "State version [$state_version]: " input
[[ -n "$input" ]] && state_version="$input"

# Architecture
read -r -p "Architecture [$arch]: " input
[[ -n "$input" ]] && arch="$input"

# Hostname
read -r -p "Hostname [$hostname]: " input
[[ -n "$input" ]] && hostname="$input"

# Username
read -r -p "Username [$username]: " input
[[ -n "$input" ]] && username="$input"

# Timezone
read -r -p "Timezone [$timezone]: " input
[[ -n "$input" ]] && timezone="$input"

# Locale
read -r -p "Locale [$locale]: " input
[[ -n "$input" ]] && locale="$input"

# Keyboard layout
read -r -p "Keyboard layout [$keyboard_layout]: " input
[[ -n "$input" ]] && keyboard_layout="$input"

# Keyboard variant
read -r -p "Keyboard variant [$keyboard_variant]: " input
[[ -n "$input" ]] && keyboard_variant="$input"

sleep 1

# -----------------------------------------------------------------------------
# Phase 2: Get user configuration
# -----------------------------------------------------------------------------

clear

print_header 2 "Get user configuration"

# Kernel
echo "Choose kernel:"
echo "  1) latest"
echo "  2) lts"
read -r -p "Selection [1]: " input

case "$input" in
"" | 1)
    kernel="latest"
    ;;
2)
    kernel="lts"
    ;;
*)
    echo "Invalid selection."
    exit 1
    ;;
esac

echo

# Desktop
echo "Choose desktop environment:"
echo "  1) niri"
echo "  2) gnome"
echo "  3) kde"
echo "  4) none"
read -r -p "Selection [1]: " input

case "$input" in
"" | 1)
    desktop="niri"
    ;;
2)
    desktop="gnome"
    ;;
3)
    desktop="kde"
    ;;
4)
    desktop="none"
    ;;
*)
    echo "Invalid selection."
    exit 1
    ;;
esac

echo

# Virtualization
echo "Choose virtualization mode:"
echo "  1) host"
echo "  2) guest"
echo "  3) none"
read -r -p "Selection [1]: " input

case "$input" in

# Host
"" | 1)
    virtualization_mode="host"

    # Host backends
    echo
    echo "Choose virtualization backends:"
    echo "  1) qemu"
    echo "  2) virtualbox"
    read -r -p "Selection [1]: " input

    case "$input" in
    "" | 1)
        virtualization_backends=("qemu")

        # QEMU frontends
        echo
        echo "Choose virtualization frontends:"
        echo "  1) virt-manager"
        echo "  2) none"
        read -r -p "Selection [1]: " input

        case "$input" in
        "" | 1)
            virtualization_frontends=("virt-manager")
            ;;
        2)
            virtualization_frontends=()
            ;;
        *)
            echo "Invalid selection."
            exit 1
            ;;
        esac
        ;;

    2)
        virtualization_backends=("virtualbox")
        virtualization_frontends=("virtualbox")
        ;;
    *)
        echo "Invalid selection."
        exit 1
        ;;
    esac
    ;;

# Guest
2)
    virtualization_mode="guest"

    # Guest backends
    echo
    echo "Choose virtualization backends:"
    echo "  1) qemu"
    echo "  2) virtualbox"
    read -r -p "Selection [1]: " input

    case "$input" in
    "" | 1)
        virtualization_backends=("qemu")
        ;;
    2)
        virtualization_backends=("virtualbox")
        ;;
    *)
        echo "Invalid selection."
        exit 1
        ;;
    esac
    ;;
3)
    virtualization_mode="none"
    virtualization_backends=()
    ;;
*)
    echo "Invalid selection."
    exit 1
    ;;
esac

echo

# Full name
echo "Enter your full name."
read -r -p "Full name: " fullname

echo

# Git name
echo "Enter your git username."
read -r -p "Git username: " gitName

echo

# E-Mail
echo "Enter E-Mail address to use for git."
read -r -p "Git email: " gitEmail

# Screenshot path
echo "Enter screenshot path."
read -r -p "Screenshot path: " screenshot_path

sleep 1

# -----------------------------------------------------------------------------
# Phase 3: Print configuration summary
# -----------------------------------------------------------------------------

clear

print_header 3 "Configuration summary"

echo "-------------------------- System information"
printf '  %-26s %s\n' "System state version:" "$state_version"
printf '  %-26s %s\n' "Architecture:" "$arch"
printf '  %-26s %s\n' "Kernel:" "$kernel"
printf '  %-26s %s\n' "Hostname:" "$hostname"
printf '  %-26s %s\n' "Timezone:" "$timezone"
printf '  %-26s %s\n' "Locale:" "$locale"
printf '  %-26s %s\n' "Keyboard layout:" "$keyboard_layout"
printf '  %-26s %s\n' "Keyboard variant:" "$keyboard_variant"

echo
echo "-------------------------- User configuration"
printf '  %-26s %s\n' "Username:" "$username"
printf '  %-26s %s\n' "Full name:" "$fullname"
printf '  %-26s %s\n' "Git name:" "$gitName"
printf '  %-26s %s\n' "Git email:" "$gitEmail"
printf '  %-26s %s\n' "Screenshot path:" "$screenshot_path"

echo
echo "--------------------------------- Environment"
printf '  %-26s %s\n' "Desktop:" "$desktop"

echo
echo "------------------------------------ Features"
printf '  %-26s %s\n' "Virtualization mode:" "$virtualization_mode"
printf '  %-26s %s\n' "Virtualization backends:" "${virtualization_backends[*]:-none}"
printf '  %-26s %s\n' "Virtualization frontends:" "${virtualization_frontends[*]:-none}"

echo

read -r -p "Is this configuration correct? [Y/n] " confirm

# ----------------------------------- Confirm configuration
case "$confirm" in
"" | y | Y | yes | Yes | YES)
    echo "Configuration accepted."
    ;;
*)
    echo "Installation cancelled."
    exit 1
    ;;
esac

sleep 1

# -----------------------------------------------------------------------------
# Phase 4: Create local repository
# -----------------------------------------------------------------------------

clear

print_header 4 "Create local repository"

echo
echo "Creating repository directory:"

if [[ "$installation_mode" == "iso" ]]; then
    repository_path="/mnt/home/$username/.younix"
else
    repository_path="/home/$username/.younix"
fi

sudo mkdir -p "$repository_path"

git -C "$repository_path" init -b main

sleep 1

# -----------------------------------------------------------------------------
# Phase 5: Prepare local repository
# -----------------------------------------------------------------------------

clear

print_header 5 "Prepare local repository"

echo
echo "Move hardware-configuration.nix"

if [[ "$installation_mode" == "iso" ]]; then
    nixos-generate-config --root /mnt
    hardware_path="/mnt/etc/nixos/hardware-configuration.nix"
else
    echo
    echo "Enter path to hardware-configuration.nix."
    read -r -p "Hardware-configuration path: " hardware_path
fi

cp "$hardware_path" \
    "$repository_path/hardware-configuration.nix"

echo
echo "Create younix-config.nix"

cat >"$repository_path/younix-config.nix" <<EOF
# file: younix-config.nix

# #############################################################################
#
# Description:
# This file collects some of the most important settings for the system.
# It was filled automatically by \`younix-install.sh\` if you used it.
#
# Content:
#   - System Settings
#   - Maintenace
#   - User Settings
#   - Environment Settings
#   - Feature Settings
#
# #############################################################################

{

  # SYSTEM SETTINGS ===========================================================

  system = {

    # State version ---------------------------------------
    # DO NOT TOUCH unless you know what you are doing
    stateVersion = "$state_version";

    # Hardware and Kernel ---------------------------------
    arch = "$arch";
    # Options: "latest", "lts"
    kernel = "$kernel";

    # Host ------------------------------------------------
    # Must be a valid hostname (no spaces, lowercase recommended)
    hostname = "$hostname";

    # Localization ----------------------------------------
    timezone = "$timezone";
    locale = "$locale";

  };

  # MAINTENANCE ===============================================================

  maintenance = {

    # Boot menu -------------------------------------------
    # Maximum number of system generations shown in the boot menu
    bootMenuEntries = 10;

    # Garbage collection ----------------------------------
    garbageCollection = {
      # Enable automatic garbage collection
      enable = true;
      # When to run automatic garbage collection
      schedule = "weekly";
      # Maximum age of store paths to keep
      retention = "30d";
    };

  };

  # USER SETTINGS =============================================================

  user = {

    # Main user -------------------------------------------
    # Must be a valid username (no spaces, lowercase, ...)
    username = "$username";
    # Fullname of the user
    fullname = "$fullname";
    # Git name
    gitName = "$gitName";
    # Email used for git
    gitEmail = "$gitEmail";
    # Local configuration path
    configPath = "$repository_path";

  };

  # ENVIRONMENT SETTINGS ======================================================

  environment = {

    # Chosen desktop environment stack --------------------
    # Options: "niri", "gnome", "kde", "none"
    desktop = "$desktop";

    # Screenshot path -------------------------------------
    screenshotPath = "$screenshot_path";

    # Keyboard layout -------------------------------------
    keyboard = {
      # Multiple layouts can be comma seperated
      layout = "$keyboard_layout";
      # Variant has to match the layout above
      variant = "$keyboard_variant";
    };

  };

  # FEATURE SETTINGS ==========================================================

  features = {

    # Virtualization --------------------------------------
    virtualization = {
      # Options: "host", "guest", "none"
      mode = "$virtualization_mode";
      # Options (list of): "qemu", "virtualbox"
      backends = [
EOF

for backend in "${virtualization_backends[@]}"; do
    printf '        "%s"\n' "$backend" >>"$repository_path/younix-config.nix"
done

cat >>"$repository_path/younix-config.nix" <<EOF
      ];
      # Options (list of): "virt-manager" or empty list
      frontends = [
EOF

for frontend in "${virtualization_frontends[@]}"; do
    printf '        "%s"\n' "$frontend" >>"$repository_path/younix-config.nix"
done

cat >>"$repository_path/younix-config.nix" <<EOF
      ];
    };

  };

}
EOF

echo
echo "Copying YouNIX files"

tar \
    --exclude='./.git' \
    --exclude='./dev' \
    --exclude='./docs' \
    --exclude='./younix-config.nix' \
    -cf - . |
    tar -xf - -C "$repository_path"

sleep 1

# -----------------------------------------------------------------------------
# Phase 6: YouNIX Installation
# -----------------------------------------------------------------------------

clear

print_header 6 "YouNIX Installation"

echo
echo "Installation started ..."
echo

if [[ "$installation_mode" == "iso" ]]; then
    nixos-install --flake "$repository_path#$hostname"
else
    sudo nixos-rebuild boot --flake "$repository_path#$hostname"
fi

echo
echo "Installation finished successfully."

sleep 1

# -----------------------------------------------------------------------------
# Phase 7: Finish installation
# -----------------------------------------------------------------------------

clear

print_header 7 "Finish installation"

if [[ "$installation_mode" == "iso" ]]; then
    echo
    echo "Set repository ownership"
    echo
    sudo chown -R "$username:users /mnt/home/$username/.younix"
    echo "New owner is: $username"

    sleep 1

    echo "Set password for user: $username"
    sudo nixos-enter --root /mnt -- passwd "$username"

fi

sleep 1

echo
echo "Installation complete. System will reboot now."

sleep 1

sudo systemctl reboot
