# file: composers/system-composer.nix

# #############################################################################
#
# Description:
# Composes system relevant components like system core features,
# system maintenance and system users as well as fonts.
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

  # -------------------------------------------------- Core

  # Import entrypoints
  core = import ./../../system/core;

  # Create context aware module lists
  coreComponent = {
    nixosModules = core.nixosModules;

    hmModules = core.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------- Maintenance

  # Import entrypoints
  maintenance = import ./../../system/maintenance;

  # Create context aware module lists
  maintenanceComponent = {
    nixosModules = maintenance.nixosModules;

    hmModules = maintenance.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------------- Users

  # Import entrypoints
  users = import ./../../system/users;

  # Create context aware module lists
  usersComponent = {
    nixosModules = users.nixosModules;

    hmModules = users.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------------- Fonts

  # Import entrypoints
  fonts = import ./../../system/fonts;

  # Create context aware module lists
  fontsComponent = {
    nixosModules = fonts.nixosModules;

    hmModules = fonts.hmModules;

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

    # ------------------------------------------------ Core

    (composeComponent coreComponent)

    # ----------------------------------------- Maintenance

    (composeComponent maintenanceComponent)

    # ----------------------------------------------- Users

    (composeComponent usersComponent)

    # ----------------------------------------------- Fonts

    (composeComponent fontsComponent)

  ];

}
