#!/usr/bin/env bash

set -euo pipefail

# =============================================================================
# YouNIX Installer
#
# Phase 1  -  Reading system information
# Phase 2  -  Print system information
# Phase 3  -  Set configuration values
# Phase 4  -  Print configuration summary
# Phase 6  -  Create `younix-config.nix`
# Phase 7  -  Choose personal repository
# Phase 8  -  Push complete configuration to personal repository
# Phase 9  -  Delete cloned upstream repository on user choice
# Phase 10 -  Rebuild and reboot the system
#
# =============================================================================

# -----------------------------------------------------------------------------
# Phase 1: Reading system information
# -----------------------------------------------------------------------------

echo "Reading system information..."

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

# -----------------------------------------------------------------------------
# Phase 2: Print system information
# -----------------------------------------------------------------------------

# ----------------------- Print detected system information
echo
echo "Detected system information:"
echo
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
    echo "System information accepted."
    sleep 1
    ;;
*)
    echo "System information will be configured manually."
    sleep 1
    ;;
esac

# -----------------------------------------------------------------------------
# Phase 3: Set configuration
# -----------------------------------------------------------------------------

# ---------------------- Change detected system information
if [[ "$confirm" != "" && "$confirm" != "y" && "$confirm" != "Y" &&
    "$confirm" != "yes" && "$confirm" != "Yes" && "$confirm" != "YES" ]]; then

    clear
    echo "Please enter the correct values. Press ENTER to accept individual value."
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

sleep 1

# ------------------------------------- Users configuration
clear
echo "YouNIX configuration:"
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

clear

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

clear

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

clear

# Full name
echo "Enter your full name. (It is used for the git configuration)"
read -r -p "Full name: " fullname

clear

# E-Mail
echo "Enter your E-Mail address. (It is used for the git configuration)"
read -r -p "Email: " email

clear

# Screenshot path
pictures_path="$(xdg-user-dir PICTURES)"
screenshot_path="${pictures_path}/Screenshots"

echo "Enter your desired path to save screenshots."
read -r -p "Screenshot path [$screenshot_path]: " input

if [[ -n "$input" ]]; then
    screenshot_path="$input"
fi

sleep 1

# ----------------------------- Final configuration summary
clear
echo "YouNIX configuration:"
echo

printf '  %-26s %s\n' "System state version:" "$state_version"
printf '  %-26s %s\n' "Architecture:" "$arch"
printf '  %-26s %s\n' "Kernel:" "$kernel"
printf '  %-26s %s\n' "Hostname:" "$hostname"
printf '  %-26s %s\n' "Timezone:" "$timezone"
printf '  %-26s %s\n' "Locale:" "$locale"
printf '  %-26s %s\n' "Keyboard layout:" "$keyboard_layout"
printf '  %-26s %s\n' "Keyboard variant:" "$keyboard_variant"

echo
printf '  %-26s %s\n' "Username:" "$username"
printf '  %-26s %s\n' "Full name:" "$fullname"
printf '  %-26s %s\n' "Email:" "$email"

echo
printf '  %-26s %s\n' "Desktop:" "$desktop"
printf '  %-26s %s\n' "Screenshot path:" "$screenshot_path"

echo
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

# -----------------------------------------------------------------------------
# Phase 4: Choose repository
# -----------------------------------------------------------------------------

clear
echo "Choose YouNIX repository:"
echo "  1) remote repository"
echo "  2) local repository"
read -r -p "Selection [1]: " input

case "$input" in
"" | 1)
    repository_source="remote"

    read -r -p "Repository URL: " repository_url
    read -r -p "Repository path: " repository_path
    ;;
2)
    repository_source="local"

    read -r -p "Local repository path: " repository_path
    ;;
*)
    echo "Invalid selection."
    exit 1
    ;;
esac

# -----------------------------------------------------------------------------
# Phase 5: Setup user repository
# -----------------------------------------------------------------------------

clear
echo "Preparing YouNIX repository..."

case "$repository_source" in

# ---------------------------------------- Local repository
local)
    if [[ -e "$repository_path" ]]; then
        if [[ ! -d "$repository_path" ]]; then
            echo "The specified path exists but is not a directory:"
            echo "  $repository_path"
            exit 1
        fi

        if [[ -d "$repository_path/.git" ]]; then
            echo "Using existing Git repository:"
            echo "  $repository_path"
        else
            echo "The specified path is not a Git repository."
            echo "Initializing a new Git repository..."
            git -C "$repository_path" init -b main
        fi
    else
        echo "Creating repository directory:"
        echo "  $repository_path"

        mkdir -p "$repository_path"
        git -C "$repository_path" init -b main
    fi
    ;;

# --------------------------------------- Remote repository
remote)
    if [[ -e "$repository_path" ]]; then
        echo "The local repository path already exists:"
        echo "  $repository_path"
        exit 1
    fi

    while true; do
        echo
        echo "Checking remote repository..."

        if git ls-remote "$repository_url" &>/dev/null; then
            break
        fi

        echo
        echo "The remote repository could not be reached or does not exist."
        echo
        read -r -p "Repository URL: " repository_url
    done

    echo
    echo "Cloning repository..."
    git clone "$repository_url" "$repository_path"
    ;;

*)
    echo "Invalid repository source."
    exit 1
    ;;

esac

# -----------------------------------------------------------------------------
# Phase 7: Create `younix-config.nix`
# -----------------------------------------------------------------------------

clear
echo "Creating younix-config.nix..."
sleep 1

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
    # Fullname is used for git name
    fullname = "$fullname";
    # Email is used for git email
    email = "$email";

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

# -----------------------------------------------------------------------------
# Phase 8: Copy files to user repository
# -----------------------------------------------------------------------------

# ---------------------------------- Hardware-configuration
echo "Copying hardware-configuration.nix..."
sleep 1

cp /etc/nixos/hardware-configuration.nix \
    "$repository_path/hardware-configuration.nix"

# -------------------------------------------- YouNIX files
echo "Copying YouNIX files ..."
sleep 1

tar \
    --exclude='./.git' \
    --exclude='./dev' \
    --exclude='./docs' \
    --exclude='./younix-config.nix' \
    --exclude='./younix-install.sh' \
    -cf - . |
    tar -xf - -C "$repository_path"

# -----------------------------------------------------------------------------
# Phase 9: Commit and push changes to user repository
# -----------------------------------------------------------------------------

# ------------------------------------------ Initial Commit
clear
echo "Creating initial commit..."

git -C "$repository_path" add .

git -C "$repository_path" \
    -c user.name="$fullname" \
    -c user.email="$email" \
    commit -m "Initial YouNIX configuration"

# ------------- Pushing initial commit to remote repository
if [[ "$repository_source" == "remote" ]]; then
    echo "Pushing initial commit ..."
    git -C "$repository_path" push
fi

# -----------------------------------------------------------------------------
# Phase 7: Geklonte Repository-Version löschen?
# -----------------------------------------------------------------------------

# TODO: Fragen, ob temporäre Kopie gelöscht werden soll

# -----------------------------------------------------------------------------
# Phase 8: NixOS rebuild und Neustart
# -----------------------------------------------------------------------------

# TODO: NixOS rebuild durchführen
# TODO: Neustart durchführen

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------

echo "YouNIX installation completed."
