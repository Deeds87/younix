# file: composers/cli-composer.nix

# #############################################################################
#
# Description:
# Composes cli tools and applications.
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

  # --------------------------------------------- Fastfetch

  # Import entrypoints
  fastfetch = import ./../../software/cli/fastfetch;

  # Create context aware module lists
  fastfetchComponent = {
    nixosModules = fastfetch.nixosModules;

    hmModules = fastfetch.hmModules;

    initActions = [ ];
  };

  # --------------------------------------------------- GIT

  # Import entrypoints
  git = import ./../../software/cli/git;

  # Create context aware module lists
  gitComponent = {
    nixosModules = git.nixosModules;

    hmModules = git.hmModules;

    initActions = [ ];
  };

  # --------------------------------------------------- LSD

  # Import entrypoints
  lsd = import ./../../software/cli/lsd;

  # Create context aware module lists
  lsdComponent = {
    nixosModules = lsd.nixosModules;

    hmModules = lsd.hmModules;

    initActions = [ ];
  };

  # ----------------------------------------- Speedtest-CLI

  # Import entrypoints
  speedtestCli = import ./../../software/cli/speedtest-cli;

  # Create context aware module lists
  speedtestCliComponent = {
    nixosModules = speedtestCli.nixosModules;

    hmModules = speedtestCli.hmModules;

    initActions = [ ];
  };

  # ---------------------------------------------- Starship

  # Import entrypoints
  starship = import ./../../software/cli/starship;

  # Create context aware module lists
  starshipComponent = {
    nixosModules = starship.nixosModules;

    hmModules = starship.hmModules;

    initActions = [ ];
  };

  # ------------------------------------------------ Zoxide

  # Import entrypoints
  zoxide = import ./../../software/cli/zoxide;

  # Create context aware module lists
  zoxideComponent = {
    nixosModules = zoxide.nixosModules;

    hmModules = zoxide.hmModules;

    initActions = [ ];
  };

  # --------------------------------------------------- ZSH

  # Import entrypoints
  zsh = import ./../../software/cli/zsh;

  # Create context aware module lists
  zshComponent = {
    nixosModules = zsh.nixosModules;

    hmModules = zsh.hmModules;

    initActions = [ ];
  };

  # -------------------------------------------------- DGOP

  # Import entrypoints
  dgop = import ./../../software/cli/dgop;

  # Create context aware module lists
  dgopComponent = {
    nixosModules = dgop.nixosModules;

    hmModules = dgop.hmModules;

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

    # ----------- ------------------------------- Fastfetch

    (composeComponent fastfetchComponent)

    # ----------- ------------------------------------- GIT

    (composeComponent gitComponent)

    # ----------- ------------------------------------- LSD

    (composeComponent lsdComponent)

    # ----------- --------------------------- Speedtest-CLI

    (composeComponent speedtestCliComponent)

    # ----------- -------------------------------- Starship

    (composeComponent starshipComponent)

    # ----------- ---------------------------------- Zoxide

    (composeComponent zoxideComponent)

    # ----------- ------------------------------------- ZSH

    (composeComponent zshComponent)

    # ----------- ------------------------------------ DGOP

    (composeComponent dgopComponent)

  ];

}
