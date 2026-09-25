# file: younix-config.nix

# #############################################################################
#
# Description:
# This file collects some of the most important settings for the system.
# It was filled automatically by `younix-install.sh` if you used it.
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
    stateVersion = "26.05";

    # Hardware and Kernel ---------------------------------
    arch = "x86_64-linux";
    # Options: "latest", "lts"
    kernel = "latest";

    # Host ------------------------------------------------
    # Must be a valid hostname (no spaces, lowercase recommended)
    hostname = "nixos";

    # Localization ----------------------------------------
    timezone = "Europe/Berlin";
    locale = "de_DE.UTF-8";

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
    username = "john";
    # Fullname of the user
    fullname = "John Doe";
    # Git name
    gitName = "John Doe";
    # Email used for git
    gitmail = "user@localhost";
    # Local configuration path
    configPath = "/home/nixos/.younix";

  };

  # ENVIRONMENT SETTINGS ======================================================

  environment = {

    # Chosen desktop environment stack --------------------
    # Options: "niri", "gnome", "kde", "none"
    desktop = "niri";

    # Screenshot path -------------------------------------
    screenshotPath = "~/Bilder/Screenshots";

    # Keyboard layout -------------------------------------
    keyboard = {
      # Multiple layouts can be comma seperated
      layout = "us-swapped-zy,de,de";
      # Variant has to match the layout above
      variant = ",nodeadkeys,us";
    };

  };

  # FEATURE SETTINGS ==========================================================

  features = {

    # Virtualization --------------------------------------
    virtualization = {
      # Options: "host", "guest", "none"
      mode = "host";
      # Options (list of): "qemu", "virtualbox"
      backends = [
        "qemu"
      ];
      # Options (list of): "virt-manager" or empty list
      frontends = [
        "virt-manager"
      ];
    };

  };

}
