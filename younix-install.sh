#!/usr/bin/env bash

set -euo pipefail

# -----------------------------------------------------------------------------
# Installer dependencies
# -----------------------------------------------------------------------------

if [[ -z "${YOUNIX_INSTALLER_ENV:-}" ]]; then
    export YOUNIX_INSTALLER_ENV=1
    exec nix-shell -p git xdg-user-dirs --run "$0"
fi

# =============================================================================
# YouNIX Installer
#
# Phase 1  -  Reading system information
# Phase 2  -  Print detected system information
# Phase 3  -  Set configuration values
# Pahse 4  -  Creating user directories
# Phase 5  -  Personal repository setup
# Phase 6  -  Create `younix-config.nix` file
# Phase 7  -  Copy files into personal repository
# Phase 8  -  Finish repository setup
# Phase 9  -  Rebuild and reboot the system
#
# =============================================================================

print_header() {
    cat <<EOF

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

YouNIX Installation ($1 / 9)

Phase $1: $2

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

EOF
}

# -----------------------------------------------------------------------------
# Phase 1: Reading system information
# -----------------------------------------------------------------------------

clear

print_header 1 "Reading system information..."

state_version=""
arch=""
hostname=""
username=""
timezone=""
locale=""
keyboard_layout=""
keyboard_variant=""

# -------------------------------------------- Architecture
arch="$(nix-instantiate --eval --expr 'builtins.currentSystem' 2>/dev/null | tr -d '"')"

# ------------------------------------------------ Hostname
hostname="$(hostnamectl --static)"

# ------------------------------------------------ Username
if [[ "${EUID}" -eq 0 ]]; then
    echo "Do not run younix-install.sh as root."
    exit 1
fi

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

sleep 1

# -----------------------------------------------------------------------------
# Phase 2: Print detected system information
# -----------------------------------------------------------------------------

# ----------------------- Print detected system information
clear

print_header 2 "Detected system information"

printf '  %-18s %s\n' "State version:" "$state_version"
printf '  %-18s %s\n' "Architecture:" "$arch"
printf '  %-18s %s\n' "Hostname:" "$hostname"
printf '  %-18s %s\n' "Username:" "$username"
printf '  %-18s %s\n' "Timezone:" "$timezone"
printf '  %-18s %s\n' "Locale:" "$locale"
printf '  %-18s %s\n' "Keyboard layout:" "$keyboard_layout"
printf '  %-18s %s\n' "Keyboard variant:" "$keyboard_variant"
echo

# --------------------- Confirm detected system information
read -r -p "Are these values correct? [Y/n] " confirm

case "$confirm" in
"" | y | Y | yes | Yes | YES)
    echo
    echo "System information accepted."
    ;;
*)
    echo
    echo "System information will be configured manually."
    ;;
esac

sleep 1

# -----------------------------------------------------------------------------
# Phase 3: Set configuration
# -----------------------------------------------------------------------------

clear

print_header 4 "Set configuration values"

# ---------------------- Change detected system information
if [[ "$confirm" != "" && "$confirm" != "y" && "$confirm" != "Y" &&
    "$confirm" != "yes" && "$confirm" != "Yes" && "$confirm" != "YES" ]]; then

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
fi

# ------------------------------------- Users configuration
echo
echo "Personal configuration:"
echo

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

echo

# ----------------------------- Final configuration summary
clear

print_header 4 "Configuration summary."

echo

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
# Phase 4: Creating user directories
# -----------------------------------------------------------------------------

clear

print_header 4 "Create user directories"

user_home="/home/$username"

if id "$username" &>/dev/null; then
    sudo -u "$username" \
        env HOME="$user_home" \
        LANG="$locale" \
        LC_ALL="$locale" \
        xdg-user-dirs-update
else
    sudo mkdir -p "$user_home"
    sudo chown "$USER:$(id -gn)" "$user_home"

    HOME="$user_home" \
        LANG="$locale" \
        LC_ALL="$locale" \
        xdg-user-dirs-update
fi

echo "Created user directories:"
HOME="$user_home" xdg-user-dir DESKTOP
HOME="$user_home" xdg-user-dir DOCUMENTS
HOME="$user_home" xdg-user-dir DOWNLOAD
HOME="$user_home" xdg-user-dir MUSIC
HOME="$user_home" xdg-user-dir PICTURES
HOME="$user_home" xdg-user-dir PROJECTS
HOME="$user_home" xdg-user-dir PUBLICSHARE
HOME="$user_home" xdg-user-dir TEMPLATES
HOME="$user_home" xdg-user-dir VIDEOS

pictures_path="$(HOME="$user_home" xdg-user-dir PICTURES)"
screenshot_path="${pictures_path}/Screenshots"

sleep 1

# -----------------------------------------------------------------------------
# Phase 5: Personal repository setup
# -----------------------------------------------------------------------------

clear

print_header 5 "Personal repository setup"

echo
echo "Creating repository directory:"

repository_path="/home/$username/.younix"

echo "  $repository_path"

if id "$username" &>/dev/null; then
    mkdir -p "$repository_path"
else
    sudo mkdir -p "$repository_path"
    sudo chown "$USER:$(id -gn)" "$repository_path"
fi

git -C "$repository_path" init -b main

sleep 1

# -----------------------------------------------------------------------------
# Phase 6: Create `younix-config.nix`
# -----------------------------------------------------------------------------

clear

print_header 6 "Creating younix-config.nix..."

echo

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

echo "Personal YouNIX configuration created."

sleep 1

# -----------------------------------------------------------------------------
# Phase 7: Copy files to user repository
# -----------------------------------------------------------------------------

clear

print_header 7 "Copy files into personal repository"

echo

# ---------------------------------- Hardware-configuration
echo "Copying hardware-configuration.nix..."
sleep 1

if [[ -f /etc/nixos/hardware-configuration.nix ]]; then
    cp /etc/nixos/hardware-configuration.nix \
        "$repository_path/hardware-configuration.nix"
elif [[ -f /mnt/etc/nixos/hardware-configuration.nix ]]; then
    cp /mnt/etc/nixos/hardware-configuration.nix \
        "$repository_path/hardware-configuration.nix"
else
    echo "hardware-configuration.nix not found."
    exit 1
fi

# -------------------------------------------- YouNIX files
echo "Copying YouNIX files ..."
sleep 1

tar \
    --exclude='./.git' \
    --exclude='./dev' \
    --exclude='./docs' \
    --exclude='./younix-config.nix' \
    -cf - . |
    tar -xf - -C "$repository_path"

sleep 1

# -----------------------------------------------------------------------------
# Phase 8: Finish repository setup
# -----------------------------------------------------------------------------

clear

print_header 8 "Finish repository setup"

echo

# ------------------------------------------ Initial Commit
echo "Creating initial commit..."

git -C "$repository_path" add .

git -C "$repository_path" \
    -c user.name="$gitName" \
    -c user.email="$gitEmail" \
    commit -m "Initial YouNIX configuration"

sleep 1

# -----------------------------------------------------------------------------
# Phase 9: NixOS rebuild and reboot
# -----------------------------------------------------------------------------

clear

print_header 9 "Rebuild and reboot the system"

echo
echo "Setup finished. The system will be rebuild and reboot."
echo

read -r -p "Press Enter to rebuild and reboot..."

sudo nixos-rebuild boot --flake "$repository_path#$hostname"

echo "Rebuild finished, system restarts now..."
sleep 1

sudo systemctl reboot
