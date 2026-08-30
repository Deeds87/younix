# file: composers/extras-composer.nix

# #############################################################################
#
# Description:
# Composes personal extras.
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

  # ------------------------------------------------ Extras

  # Import entrypoints
  extras = import ./../../extras;

  # Create context aware module lists
  extrasComponent = {
    nixosModules = extras.nixosModules;

    hmModules = extras.hmModules;

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

    # ------------------------------------------------ Extras

    (composeComponent extrasComponent)

  ];

}
