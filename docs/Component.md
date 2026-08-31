# Component

In the YouNIX context, a component is a self-contained part of the
system. It can be a small component such as an application or a complete
desktop environment.

Every component can follow the same structure:

```
componentName/
├── external-configs/                  # optional configuration files
├── home-manager/                      # optional Home Manager modules
├── nixos/                             # optional NixOS modules
└── default.nix                        # optional aggregator
```

## default.nix

If a component consists of multiple modules, it is recommended to use a
`default.nix` file to aggregate them instead of composing them directly
inside a YouNIX composer.

This keeps all component-related composition in one place and makes the
component easier to reuse independently of YouNIX.

Example:

```nix
# file: componentName/default.nix

# #############################################################################
#
# Description:
# Component description.
#
# #############################################################################

{
  # List of NixOS modules
  nixosModules = [
    ./path/to/module1
    ./path/to/module2
  ];

  # List of Home Manager modules
  hmModules = [
    ./path/to/module3
    ./path/to/module4
  ];
}
```

A `default.nix` is only required when the component benefits from
aggregating multiple modules. A component consisting of a single module
can also be provided directly as a `.nix` file.

## nixos & home-manager

All modules are regular NixOS or Home Manager modules. There are no
additional restrictions on how these modules are implemented.

A component can contain either type of module or both, depending on what
the component requires.

## external-configs/

The `external-configs/` directory can be used for default configuration
files that should be initialized when a component is activated.

These files are intended as starting configurations rather than as
declaratively managed configuration.

This is useful for applications whose configuration is normally managed
by the application itself, for example through a GUI.

For example, if KDE settings are changed through the GUI, those settings
should generally not also be managed by Home Manager. Otherwise, a
rebuild could overwrite changes made by the user through the GUI.

Instead, a component can provide initial configuration files in its
`external-configs/` directory. YouNIX can use an `initAction` with the `copy`
action to initialize these files.

An initialization action only runs when the target does not already
exist. The copied configuration therefore becomes the user's active
configuration and can subsequently be changed normally, including
through the application's GUI.

The resulting configuration can then be imported back into the user's
repository when the user wants to preserve those changes.

This keeps the configuration reproducible without preventing applications
from managing their own configuration at runtime.
