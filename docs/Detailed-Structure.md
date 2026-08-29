# Detailed Structure

- [dev](#dev) - Younix development
- [environments](#environments) - Desktop environment related components
- [extras](#extras) - Personal additions
- [features](#features) - Additional features
- [software](#software) - Available software
- [system](#system) - Core system, maintenance and users configuration
- [younix](#younix) - YouNIX layer module

---

## Dev

```
└─ dev/
   │
   │
   └─ scripts/                         # Development scripts
      │
      ├─ init-test-vm.sh                 # Init VM for YouNIX developent
      └─ run-test-vm.sh                  # Test development state on VM
```

## Environments

```
└─ environments/
   │
   │
   ├─ desktops/                        # Desktop environments & window-manager
   │  │
   │  ├─ gnome/                          # Gnome desktop
   │  │  ├─ external-configs/              # External configuration
   │  │  │  └─ .gitkeep
   │  │  ├─ home-manager/                  # Home-Manager modules
   │  │  │  └─ .gitkeep
   │  │  ├─ nixos/                         # NixOS modules
   │  │  │  └─ gnome.nix                     # Gnome module
   │  │  └─ default.nix                    # Gnome module aggregator
   │  │
   │  ├─ kde/                            # KDE desktop
   │  │  ├─ external-configs/              # External configuration
   │  │  │  └─ .gitkeep
   │  │  ├─ home-manager/                  # Home-Manager modules
   │  │  │  └─ .gitkeep
   │  │  ├─ nixos/                         # NixOS modules
   │  │  │   └─ kde.nix                      # KDE module
   │  │  └─ default.nix                    # KDE module aggregator
   │  │
   │  └─ niri/                           # Niri window-manager
   │     ├─ external-configs/              # External configuration
   │     │  └─ ...
   │     ├─ home-manager/                  # Home-Manager modules
   │     │  └─ niri.nix                      # Niri module
   │     ├─ nixos/                         # NixOS modules
   │     │  └─ niri.nix                      # Niri module
   │     └─ default.nix                    # Niri module aggregator
   │
   │
   ├─ desktop-shells/                  # Desktop-shells
   │  │
   │  └─ dms/                            # DankMaterialShell
   │     ├─ external-configs/              # External configuration
   │     │  └─ ...
   │     ├─ home-manager/                  # Home-Manager modules
   │     │  └─ dms.nix                       # DMS module
   │     ├─ nixos/                         # NixOS modules
   │     │  └─ dms.nix                       # DMS module
   │     └─ default.nix                    # DMS module aggregator
   │
   │
   └─ display-manager/                 # Display-manager
      │
      ├─ dms-greeter/                    # DMS-greeter
      │  ├─ external-configs/              # External configuration
      │  │  └─ .gitkeep
      │  ├─ home-manager/                  # Home-Manager modules
      │  │  └─ .gitkeep
      │  ├─ nixos/                         # NixOS modules
      │  │  └─ dms-greeter.nix               # DMS-greeter module
      │  └─ default.nix                    # DMS-greeter module aggregator
      │
      ├─ gdm/                            # GDM greeter
      │  ├─ external-configs/                External configuration

      │  │  └─ .gitkeep
      │  ├─ home-manager/                  # Home-Manager modules
      │  │  └─ .gitkeep
      │  ├─ nixos/                         # NixOS modules
      │  │  └─ gdm.nix                       # GDM-greeter module
      │  └─ default.nix                    # GDM-greeter module aggregator
      │
      └─ plasma-login/                   # Plasma greeter
         ├─ external-configs/              # External configuration
         │  └─ .gitkeep
         ├─ home-manager/                  # Home-Manager modules
         │  └─ .gitkeep
         ├─ nixos/                         # NixOS modules
         │  └─ plasma-login.nix              # Plasma-greeter module
         └─ default.nix                    # Plasma-greeter module aggregator
```

## Extras

This directory is intentionally shipped almost empty. It contains only a `default.nix` aggregator.

It is a special component for **personal additions and customizations to the existing system**,
such as custom XKB layouts, icon sets, themes, or other small configuration extensions
that are specific to your setup.

`extras/` is **not intended for additional applications, system services, or system features**. 
Those belong in their respective directories.


```
└── extras/ 
    ├── external-configs/              # External configuration
    │   ├── .gitkeep
    │   └── my-personal-init-dirs.nix    # EXAMPLE
    ├── home-manager/                  # Home-Manager modules
    │   ├── .gitkeep
    │   ├── my-theme.nix                 # EXAMPLE
    │   └── my-icon-set.nix              # EXAMPLE
    ├── nixos/                         # NixOS modules
    │   ├── .gitkeep
    │   ├── my-xkb-layout.nix            # EXAMPLE
    │   └── my-udev-rule.nix             # EXAMPLE
    └── default.nix                    # Extras aggregator
```

## Features

```
└── features/ 
    │
    │
    └── virtualization/                # Virtualization
        │
        ├── external-configs/            # External configuration
        │   └── .gitkeep
        ├── home-manager/                # Home-Manager modules
        │   └── .gitkeep
        ├── nixos/                       # NixOS modules
        │   ├── qemu.nix                   # qemu/kvm module
        │   └── virtualbox.nix             # virtualbox module
        └── default.nix                  # Virtualization aggregator
```

## Software

```
└── software/
    │
    │
    ├── cli/                           # Command line interface
    │   │
    │   ├── fastfetch/                   # System information
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manger modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Fastfetch aggregator
    │   │
    │   ├── git/                         # Version control
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Git aggregator
    │   │
    │   ├── lsd/                         # Modern ls alternative
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # LSD aggregator
    │   │
    │   ├── speedtest-cli/               # Internet speedtest
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Speedtest-cli aggregator
    │   │
    │   ├── starship/                    # Terminal prompt
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Starship aggregator
    │   │
    │   ├── zoxide/                      # Modern cd alternative
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Zoxide aggregator
    │   │
    │   └── zsh/                         # Z shell
    │       ├── external-configs/          # External configuration
    │       ├── home-manager/              # Home-Manager modules
    │       ├── nixos/                     # NixOS modules
    │       └── default.nix                # ZSH aggregator
    │
    ├── gui/                           # Graphical user interface
    │   │
    │   ├── brave/                       # Chromium based browser
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Brave aggregator
    │   │
    │   ├── kitty/                       # Terminal emulator
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules 
    │   │   └── default.nix                # Kitty aggregator
    │   │
    │   ├── libreoffice/                 # Office suite
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Libreoffice aggregator
    │   │
    │   ├── obsidian/                    # Notetaking app
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Obsidian aggregator
    │   │
    │   ├── synology-drive-client/       # Sync client
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Synology Drive aggregator
    │   │
    │   ├── thunderbird/                 # Email client
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Thunderbird aggregator
    │   │
    │   ├── virt-manager/                # QEMU/KVM frontend
    │   │   ├── external-configs/          # External configuration
    │   │   ├── home-manager/              # Home-Manager modules
    │   │   ├── nixos/                     # NixOS modules
    │   │   └── default.nix                # Virt-Manager aggregator
    │   │
    │   └── zen-browser/                 # Minimal firefox based browser
    │       ├── external-configs/          # External configuration
    │       ├── home-manager/              # Home-Manager modules
    │       ├── nixos/                     # NixOS modules
    │       └── default.nix                # Zen-Browser aggregator
    │
    └── tui/                           # Terminal user interface
        │
        ├── helix/                       # Modal editor
        │   ├── external-configs/          # External configuration
        │   ├── home-manager/              # Home-Manager modules
        │   ├── nixos/                     # NixOS modules
        │   └── default.nix                # Helix aggregator
        │
        ├── lazygit/                     # Git frontend
        │   ├── external-configs/          # External configuration
        │   ├── home-manager/              # Home-Manger modules
        │   ├── nixos/                     # NixOS modules
        │   └── default.nix                # Lazygit aggregator
        │
        └── yazi/                        # File explorer
            ├── external-configs/          # External configuration
            ├── home-manager/              # Home-Manager modules
            ├── nixos/                     # NixOS modules
            └── default.nix                # Yazi aggregator
```

## System

```
└── system/
    │
    │
    ├── core/                          # Core system configuration
    │   ├── external-configs/            # External configuration
    │   │   └── .gitkeep
    │   ├── home-manager/                # Home-Manager modules
    │   │   └── .gitkeep
    │   ├── nixos/                       # NixOS modules
    │   │   ├── audio.nix                  # Audio configuration
    │   │   ├── bluetooth.nix              # Bluetooth configuration
    │   │   ├── boot.nix                   # Boot setup
    │   │   ├── external-drives.nix        # External drives handling
    │   │   ├── locale.nix                 # Localization & language
    │   │   ├── networking.nix             # Network configuration
    │   │   ├── power.nix                  # Power management
    │   │   ├── printing.nix               # Printing capabilities
    │   │   ├── security.nix               # Security setup
    │   │   └── ssh.nix                    # SSH configuration
    │   └── default.nix                  # Core system configuration aggregator
    │
    ├── maintenance/                   # System maintenance
    │   ├── external-configs/            # External configuration
    │   │   └── .gitkeep
    │   ├── home-manager/                # Home-Manager modules
    │   │   └── .gitkeep
    │   ├── nixos/                       # NixOS modules
    │   │   ├── cleanup.nix                # System cleanup
    │   │   ├── general.nix                # General maintenance configuration
    │   │   └── updates.nix                # Update configuration
    │   └── default.nix                    # System maintenance aggregator
    │
    └── users/                         # System users
        ├── external-configs/            # External configuration
        │   └── .gitkeep
        ├── home-manager/                # Home-Manager modules
        │   └── .gitkeep
        ├── nixos/                       # NixOS modules
        │   └── init-user.nix              # Initial user configuration
        └── default.nix                  # System users aggregator
```

## YouNIX

```
└── younix/
    │
    │
    ├── composers/                     # YouNIX composers
    │   ├── default.nix                  # YouNIX composers aggregator
    │   ├── environment-composer.nix     # Environment composition
    │   ├── extras-composer.nix          # Personal additions composition
    │   ├── feature-composer.nix         # Additional features composition
    │   ├── system-composer.nix          # System composition
    │   ├── cli-composer.nix             # CLI apps & tools composition
    │   ├── gui-composer.nix             # GUI apps & tools composition
    │   └── tui-composer.nix             # TUI apps & tools composition
    │
    ├── core/                          # YouNIX core
    │   ├── default.nix                  # YouNIX core aggregator
    │   ├── init-actions.nix             # Init actions definition
    │   └── module.nix                   # YouNIX core module
    │
    ├── options/                       # YouNIX options
    │   ├── default.nix                  # YouNIX options aggregator
    │   ├── options.nix                  # Options definition
    │   └── options-assertions.nix       # Options assertions
    │
    └── overlays/                      # YouNIX overlays
        ├── default.nix                  # YouNIX overlays aggregator
        └── upstream-fixes.nix           # Upstream fixes
```
