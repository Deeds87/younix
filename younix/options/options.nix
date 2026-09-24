# file: younix/options/options.nix

# #############################################################################
#
# Description:
# Declares all available options for the youNIX module.
# Includes validation types to prevent invalid configuration values.
#
# #############################################################################

{ lib, ... }: {

  options.younix = {

    # SYSTEM ==================================================================
    system = {

      # Stateversion --------------------------------------
      stateVersion = lib.mkOption {
        type = lib.types.str;
        description = "NixOS and home-manager state version";
        example = "26.05";
      };

      # Architecture --------------------------------------
      arch = lib.mkOption {
        type = lib.types.str;
        description = "System architecture";
        example = "x86_64-linux";
      };

      # Kernel --------------------------------------------
      kernel = lib.mkOption {
        type = lib.types.enum [
          "latest"
          "lts"
        ];
        default = "latest";
        description = "Selects the kernel package to use.";
        example = "lts";
      };

      # Hostname ------------------------------------------
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
        description = "The system hostname.";
        example = "my-laptop";
      };

      # Timezone ------------------------------------------
      timezone = lib.mkOption {
        type = lib.types.str;
        description = "The system timezone";
        example = "Europe/Berlin";
      };

      # Locale --------------------------------------------
      locale = lib.mkOption {
        type = lib.types.str;
        description = "The system locale";
        example = "de_DE.UTF-8";
      };

    };

    # MAINTENANCE =============================================================
    maintenance = {

      # Boot menu -----------------------------------------
      bootMenuEntries = lib.mkOption {
        type = lib.types.ints.positive;
        default = 10;
        description = "Maximum number of system generations shown in the boot menu";
        example = 5;
      };

      # Garbage collection --------------------------------
      garbageCollection = lib.mkOption {
        type = lib.types.submodule {
          options = {

            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = "Toggles automatic garbage collection";
              example = false;
            };

            schedule = lib.mkOption {
              type = lib.types.str;
              default = "weekly";
              description = ''
                When the automatic garbage collection should run.
                Any value conforming to systemd calendar syntax is allowed.
              '';
              example = "daily";
            };

            retention = lib.mkOption {
              type = lib.types.str;
              default = "30d";
              description = ''
                Maximum age of store paths to keep.
                Values must be specified as a number followed by a time unit.
                Supported units: seconds (s), minutes (m), hours (h), days (d),
                weeks (w), months (M) and years (y).
              '';
              example = "14d";
            };

          };
        };
      };

    };

    # USER ====================================================================
    user = {

      # Username ------------------------------------------
      username = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
        description = "The primary username.";
        example = "alice";
      };

      # Fullname ------------------------------------------
      fullname = lib.mkOption {
        type = lib.types.str;
        default = "Nix User";
        description = "The full name of the primary user.";
        example = "Alice Doe";
      };

      # Email ---------------------------------------------
      email = lib.mkOption {
        type = lib.types.str;
        default = "user@localhost";
        description = "The email address of the primary user.";
        example = "alice@example.com";
      };

      # Config path ---------------------------------------
      configPath = lib.mkOption {
        type = lib.types.str;
        default = "/home/nixos/.younix";
        description = "Path to local YouNIX configuration";
        example = "/home/alice/.younix";
      };

    };

    # ENVIRONMENT =============================================================
    environment = {

      # Chosen desktop ------------------------------------
      desktop = lib.mkOption {
        type = lib.types.str;
        default = "gnome";
        description = "The chosen desktop environment.";
        example = "niri";
      };

      # Screenshot path -----------------------------------
      screenshotPath = lib.mkOption {
        type = lib.types.str;
        default = "Pictures/Screenshots";
        description = "Sets the path to save screenshots to.";
        example = "~/Pictures/Screenshots";
      };

      # Keyboard layout -----------------------------------
      keyboard = lib.mkOption {
        type = lib.types.submodule {
          options = {

            layout = lib.mkOption {
              type = lib.types.str;
              default = "us";
              description = "Sets the general keyboard layout.";
              example = "us";
            };

            variant = lib.mkOption {
              type = lib.types.str;
              default = "us";
              description = "Sets the specific variant of a keyboard layout.";
              example = "nodeadkeys";
            };

          };
        };
      };

    };

    # FEATURES ================================================================

    features = lib.mkOption {
      type = lib.types.submodule {
        options = {

          # Virtualization --------------------------------
          virtualization = {
            mode = lib.mkOption {
              type = lib.types.enum [
                "none"
                "host"
                "guest"
              ];
              default = "none";
              description = "Defines the virtualization role of the system.";
              example = "host";
            };
            backends = lib.mkOption {
              type = lib.types.listOf (
                lib.types.enum [
                  "qemu"
                  "virtualbox"
                ]
              );
              default = [ ];
              description = "Virtualization backends to install.";
              example = [
                "qemu"
                "virtualbox"
              ];
            };
            frontends = lib.mkOption {
              type = lib.types.listOf (
                lib.types.enum [
                  "virt-manager"
                ]
              );
              default = [ ];
              description = "Frontends to manage virtual machines.";
              example = "virt-manager";
            };
          };

        };
      };
    };

    # INITIAL initActions =========================================================

    initActions = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {

            # Action --------------------------------------
            action = lib.mkOption {
              type = lib.types.enum [
                "copy"
                "create-directory"
                "write-file"
              ];
              description = "Initialization action to perform.";
            };

            # Source --------------------------------------
            source = lib.mkOption {
              type = lib.types.nullOr lib.types.path;
              default = null;
              description = "Source path for copy actions.";
            };

            # Destination ---------------------------------
            destination = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              description = "Destionation path(s) relative to the user's home directory.";
            };

            # Content -------------------------------------
            content = lib.mkOption {
              type = lib.types.nullOr lib.types.lines;
              default = null;
              description = "Content of write-file action.";
            };

          };
        }
      );
      default = [ ];
      description = ''
        List of initialization actions that are executed once if the
        target does not already exist.
      '';
    };
  };
}
