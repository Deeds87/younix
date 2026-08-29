#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# youNIX VM Test Runner
#
# Synchronizes the current repository to a libvirt test VM and executes the
# requested nixos-rebuild action using VM-specific configuration.
#
# Usage:
#   ./dev/scripts/run-vm-test.sh [vm-name] [remote-user] [build|test|switch|boot]
#
# Examples:
#
#   ./dev/scripts/run-vm-test.sh
#     with defaults:
#       VM     = younix-dev
#       User   = john
#       Action = switch
#
#   ./dev/scripts/run-vm-test.sh testvm alice test
# =============================================================================

# -----------------------------------------------------------------------------
# Arguments
# -----------------------------------------------------------------------------

VM_NAME="${1:-younix-dev}"
REMOTE_USER="${2:-john}"
MODE="${3:-switch}"

case "$MODE" in
    build|test|switch|boot)
        ;;
    *)
        echo "❌ Invalid rebuild mode: '$MODE'"
        echo
        echo "Supported modes:"
        echo "  • build"
        echo "  • test"
        echo "  • switch (default)"
        echo "  • boot"
        exit 1
        ;;
esac

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

LOCAL_DIR="$(git rev-parse --show-toplevel)"

VM_IP="$(
    virsh -c qemu:///system domifaddr "$VM_NAME" \
        | awk '/ipv4/ { print $4 }' \
        | cut -d/ -f1
)"

if [[ -z "$VM_IP" ]]; then
    echo "❌ Could not determine the IP address of VM '$VM_NAME'."
    exit 1
fi

VM_HOST="${REMOTE_USER}@${VM_IP}"

REMOTE_DIR="/home/${REMOTE_USER}/younix-test-${VM_NAME}"
VM_CONFIG_DIR="/home/${REMOTE_USER}/vm-config"

# -----------------------------------------------------------------------------
# Information
# -----------------------------------------------------------------------------

echo "🖥️  VM      : $VM_NAME"
echo "🌐  IP      : $VM_IP"
echo "⚙️  Action  : nixos-rebuild $MODE"
echo

# -----------------------------------------------------------------------------
# Check SSH access
# -----------------------------------------------------------------------------

echo "🔐 Checking SSH access..."

if ssh -o BatchMode=yes -o ConnectTimeout=5 "$VM_HOST" "true" 2>/dev/null; then
    echo "✓ SSH key authentication works."
else
    echo "⚠️  No SSH key authentication available."

    read -rp "Copy SSH key to VM now? [Y/n] " answer

    case "${answer:-Y}" in
        [Nn]*)
            echo "❌ SSH setup aborted."
            exit 1
            ;;
        *)
            echo "🔑 Copying SSH key..."

            ssh-copy-id "$VM_HOST"

            echo "✓ SSH key copied."
            ;;
    esac
fi

echo

# -----------------------------------------------------------------------------
# Synchronize repository
# -----------------------------------------------------------------------------

echo "🔄 Synchronizing repository..."

rsync -av --delete \
    --exclude ".git" \
    --exclude "docs/" \
    --exclude "dev/" \
    --exclude "hardware-configuration.nix" \
    "$LOCAL_DIR/" \
    "$VM_HOST:$REMOTE_DIR/"

# -----------------------------------------------------------------------------
# Prepare VM configuration
# -----------------------------------------------------------------------------

echo
echo "⚙️  Preparing VM configuration..."

ssh -t "$VM_HOST" "
set -euo pipefail

cd \"$REMOTE_DIR\"

# Copy hardware configuration
cp \"$VM_CONFIG_DIR/hardware-configuration.nix\" \
   ./hardware-configuration.nix

# Adapt VM-specific settings
sed -i \
    \"s/hostname = \\\".*\\\";/hostname = \\\"$VM_NAME\\\";/\" \
    younix-config.nix

sed -i \
    \"s/username = \\\".*\\\";/username = \\\"$REMOTE_USER\\\";/\" \
    younix-config.nix

sed -i \
    \"s/mode = \\\".*\\\";/mode = \\\"guest\\\";/\" \
    younix-config.nix

sed -i \
    '/frontends = \[/,/];/c\
      frontends = [ ];' \
    younix-config.nix

echo '✓ VM configuration prepared.'

# -----------------------------------------------------------------------------
# Build system
# -----------------------------------------------------------------------------

echo
echo '🔨 Running nixos-rebuild...'

sudo nixos-rebuild $MODE --flake ".#$VM_NAME"

echo
echo '✅ nixos-rebuild completed successfully.'
"

echo
echo "🎉 Done."

