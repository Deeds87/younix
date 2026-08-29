#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
#
# youNIX Test VM Initialization
#
# Prepares a fresh NixOS VM for the youNIX development workflow.
#
# This script is intended to be executed once inside the test VM.
#
# =============================================================================

VM_CONFIG_DIR="$HOME/vm-config"
HARDWARE_CONFIG="/etc/nixos/hardware-configuration.nix"
NIXOS_CONFIG="/etc/nixos/configuration.nix"

echo "🚀 Initializing youNIX test VM..."
echo

# -----------------------------------------------------------------------------
# Create vm-config directory
# -----------------------------------------------------------------------------

echo "📁 Creating VM configuration directory..."

mkdir -p "$VM_CONFIG_DIR"

# -----------------------------------------------------------------------------
# Save hardware configuration
# -----------------------------------------------------------------------------

echo "💾 Saving hardware configuration..."

cp "$HARDWARE_CONFIG" "$VM_CONFIG_DIR/hardware-configuration.nix"

# -----------------------------------------------------------------------------
# Enable OpenSSH
# -----------------------------------------------------------------------------

echo "🔐 Configuring OpenSSH..."

if grep -q "Added by youNIX init-test-vm.sh" "$NIXOS_CONFIG"; then
    echo "   ✓ OpenSSH already enabled."
else
    sed -i '/^}$/i\
\
  # Added by youNIX init-test-vm.sh\
  services.openssh.enable = true;\
' "$NIXOS_CONFIG"

    echo "   ✓ OpenSSH enabled."
fi

# -----------------------------------------------------------------------------
# Apply configuration
# -----------------------------------------------------------------------------

echo "⚙️  Rebuilding system..."

sudo nixos-rebuild switch

# -----------------------------------------------------------------------------
# Verify SSH service
# -----------------------------------------------------------------------------

echo "🔎 Checking SSH service..."

if systemctl is-active --quiet sshd; then
    echo "   ✓ OpenSSH service is running."
else
    echo "   ❌ OpenSSH service is not running."
    exit 1
fi

# -----------------------------------------------------------------------------
# Show VM IP
# -----------------------------------------------------------------------------

VM_IP="$(hostname -I | awk '{print $1}')"

echo
echo "🌐 VM IP: $VM_IP"

# -----------------------------------------------------------------------------
# Remove temporary repository
# -----------------------------------------------------------------------------

echo

REPO_DIR="$(git rev-parse --show-toplevel)"

read -rp "🧹 Remove temporary repository? [Y/n] " answer

case "${answer:-Y}" in
    [Nn]*)
        echo "📁 Repository kept."
        ;;
    *)
        cd /tmp
        rm -rf "$REPO_DIR"
        echo "🗑️ Repository removed."
        ;;
esac

# -----------------------------------------------------------------------------
# Finished
# -----------------------------------------------------------------------------

echo
echo "✅ Test VM initialized successfully."
echo
echo "Performed actions:"
echo "  ✓ Created ~/vm-config"
echo "  ✓ Saved hardware configuration"
echo "  ✓ Enabled OpenSSH"
echo "  ✓ Rebuilt the system"
echo "  ✓ Verified SSH service"
echo
echo "You can now leave the VM and continue working from your host."

