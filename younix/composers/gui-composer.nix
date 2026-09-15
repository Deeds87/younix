# file: composers/gui-composer.nix

# #############################################################################
#
# Description:
# Composes gui tools and applications.
#
# #############################################################################

{ ... }:

let

  # Importing youNIX configration to get access to the settings.
  younixSettings = import ../../younix-config.nix;

  # VARIABLES =================================================================
  #
  # Composerwide variables can be added here.
  #
  #

  username = younixSettings.user.username;

  virtualizationFrontend = younixSettings.features.virtualization.frontends;

  # HELPER ====================================================================
  #
  # Helper functions can be added here.
  #
  #

  # Compose a component consisting of nixos modules, home-manager modules and
  # initial one time actions.
  composeComponent =
    {
      nixosModules ? [ ],
      hmModules ? [ ],
      initActions ? [ ],
    }:
    {
      # Import nixos modules into nixos context
      imports = nixosModules;
      # Import home-manager modules into home-manager context
      home-manager.users.${username}.imports = hmModules;
      # Add one time tasks on module initialization
      younix.initActions = initActions;
    };

  # COMPONENT SETUP ===========================================================
  #
  # Each component to compose has to be setup. A component setup contains module
  # imports, context aware module lists as well as a list of initial actions.
  #

  # ------------------------------------------------- Brave

  # Import entrypoints
  brave = import ./../../software/gui/brave;

  # Create context aware module lists
  braveComponent = {
    nixosModules = brave.nixosModules;

    hmModules = brave.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------------- Kitty

  # Import entrypoints
  kitty = import ./../../software/gui/kitty;

  # Create context aware module lists
  kittyComponent = {
    nixosModules = kitty.nixosModules;

    hmModules = kitty.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------- LibreOffice

  # Import entrypoints
  libreoffice = import ./../../software/gui/libreoffice;

  # Create context aware module lists
  libreofficeComponent = {
    nixosModules = libreoffice.nixosModules;

    hmModules = libreoffice.hmModules;

    initActions = [ ];
  };

  # ---------------------------------------------- Obsidian

  # Import entrypoints
  obsidian = import ./../../software/gui/obsidian;

  # Create context aware module lists
  obsidianComponent = {
    nixosModules = obsidian.nixosModules;

    hmModules = obsidian.hmModules;

    initActions = [ ];
  };

  # --------------------------------- Synology-Drive-Client

  # Import entrypoints
  synologyDrive = import ./../../software/gui/synology-drive-client;

  # Create context aware module lists
  synologyDriveComponent = {
    nixosModules = synologyDrive.nixosModules;

    hmModules = synologyDrive.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------- Thunderbird

  # Import entrypoints
  thunderbird = import ./../../software/gui/thunderbird;

  # Create context aware module lists
  thunderbirdComponent = {
    nixosModules = thunderbird.nixosModules;

    hmModules = thunderbird.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------ Virt-Manager

  # Import entrypoints
  virtManager = import ./../../software/gui/virt-manager;

  # Create context aware module lists
  virtManagerComponent = {
    nixosModules = virtManager.nixosModules;

    hmModules = virtManager.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------- Zen-Browser

  # Import entrypoints
  zenBrowser = import ./../../software/gui/zen-browser;

  # Create context aware module lists
  zenBrowserComponent = {
    nixosModules = zenBrowser.nixosModules;

    hmModules = zenBrowser.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------ Dankcalendar

  # Import entrypoints
  dankcalendar = import ./../../software/gui/dankcalendar;

  # Create context aware module lists
  dankcalendarComponent = {
    nixosModules = dankcalendar.nixosModules;

    hmModules = dankcalendar.hmModules;

    initActions = [ ];
  };

in

{

  # COMPOSED COMPONENT IMPORTS ================================================
  #
  # Import composed components. Imports can be direct (static) or conditional.
  #
  #

  imports = [

    # ----------- ----------------------------------- Brave

    (composeComponent braveComponent)

    # ----------- ----------------------------------- Kitty

    (composeComponent kittyComponent)

    # ----------- ----------------------------- LibreOffice

    (composeComponent libreofficeComponent)

    # ----------- -------------------------------- Obsidian

    (composeComponent obsidianComponent)

    # -------------------------------- Synology-Drive-Client

    (composeComponent synologyDriveComponent)

    # ----------- ----------------------------- Thunderbird

    (composeComponent thunderbirdComponent)

    # ----------- ---------------------------- Virt-Manager

    (if virtualizationFrontend == "virt-manager" then (composeComponent virtManagerComponent) else { })

    # ----------- ----------------------------- Zen-Browser

    (composeComponent zenBrowserComponent)

    # ---------------------------------------- Dankcalendar

    (composeComponent dankcalendarComponent)

  ];

}
