# Scripts

## Test VM Preperation

file: `init-test-vm.sh`

### Description

This script prepares a virtual machine for the younix dev workflow.
It is intended to be executed once on the test VM.

### Requirements

- Fresh NixOS installation
- `configuration.nix` and `hardware-configuration.nix` are in the default location

### What it does

1. Create `~/vm-config` directory
2. Copy `/etc/nixos/hardware-configuration.nix` to `vm-config` directory
3. Enable OpenSSH in `/etc/nixos/configuration.nix`
4. Rebuild the system
5. Verify OpenSSH service is up and running
6. Print VM IP

---

## VM Test Runner

file: run-vm-test.sh

### Description 

This script synchronizes the current repository (branch) to a libvirt test VM and
executes the requested nixos-rebuild action using VM-specific configuration.

### Usage

Run `./dev/scripts/run-vm-test.sh [vm-name] [remote-user] [build|test|switch|boot]`.

If no parameter is given to the script it uses the defaults:

- vm-name: younix-dev
- remote-user: john
- mode: switch

### What it does

1. Check SSH access to the VM and copy SSH-keys if needed
2. Synchronize repository to `~/younix-test-${VM_NAME}`
3. Copy `hardware-configuration.nix` from `~/vm-config` to the repository
4. Adapt VM settings (`~/younix-test-${VM_NAME}/younix-config.nix`):
    - hostname
    - username
    - set younix virtualization mode to guest
5. Rebuild the system with the given mode
