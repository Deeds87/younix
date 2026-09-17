# file: composers/tui-composer.nix

# #############################################################################
#
# Description:
# Composes tui tools and applications.
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

  # ------------------------------------------------ Nixvim

  # Import entrypoints
  nixvim = import ./../../software/tui/nixvim;

  # Create context aware module lists
  nixvimComponent = {
    nixosModules = nixvim.nixosModules;

    hmModules = nixvim.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------------- Helix

  # Import entrypoints
  helix = import ./../../software/tui/helix;

  # Create context aware module lists
  helixComponent = {
    nixosModules = helix.nixosModules;

    hmModules = helix.hmModules;

    initActions = [ ];
  };

  # ----------------------------------------------- LazyGit

  # Import entrypoints
  lazygit = import ./../../software/tui/lazygit;

  # Create context aware module lists
  lazygitComponent = {
    nixosModules = lazygit.nixosModules;

    hmModules = lazygit.hmModules;

    initActions = [ ];
  };

  # -------------------------------------------------- Yazi

  # Import entrypoints
  yazi = import ./../../software/tui/yazi;

  # Create context aware module lists
  yaziComponent = {
    nixosModules = yazi.nixosModules;

    hmModules = yazi.hmModules;

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

    # ---------------------------------------------- Nixvim

    (composeComponent nixvimComponent)

    # ----------- ----------------------------------- Helix

    (composeComponent helixComponent)

    # ----------- --------------------------------- LazyGit

    (composeComponent lazygitComponent)

    # ----------- ------------------------------------ Yazi

    (composeComponent yaziComponent)

  ];

}
