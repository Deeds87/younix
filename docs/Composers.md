# Composers

Composers use youNIX settings and components to compose specific system areas
such as the environment, system, maintenance, applications, additional features,
and extras.

Settings defined in `younix-config.nix` can be used by composers to select
and configure components. Components can also be composed directly when
no corresponding setting exists.

Every composer follows the same structure:

1. General composer settings (variables, helper functions)
2. Component setup
3. Composed component imports

Generic composer template:


```nix
# file: composers/filename.nix TODO: Change filename

# #############################################################################
#
# Description:
# TODO: Add description
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

  # Example:
  #
  # desktop = younixSettings.environment.desktop;
  
  # TODO: Add variables

  # HELPER ====================================================================
  #
  # Helper functions can be added here.
  #
  # 

  # Compose a component consisting of nixos modules, home-manager modules and
  # initial one time actions.
  composeComponent =
    { nixosModules ? [ ], hmModules ? [ ], initActions ? [ ] }:
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

  # TODO: Add components

  # Example:
  # ----------------------------------------- componentName
  #
  # Import entrypoints.
  #
  # An entrypoint can either be a component entrypoint (default.nix)
  # providing nixosModules and hmModules, or a module entrypoint
  # providing a single NixOS or Home-Manager module. (For further
  # information read `Component` documentation)
  #
  # entrypoint1 = import ./pathToModule/entryPoint
  # entrypoint2 = import ./pathToModule/entryPointFile.nix
  # entrypoint3 = import ./pathToModule/entryPointFile.nix
  # entrypoint4 = import ./pathToModule/entryPointFile.nix
  #
  # Create context aware module lists
  # 
  # componentName = {
  #
  #  nixosModules =
  #   entrypoint1.nixosModules
  #   ++ [entrypoint2];
  # 
  #  hmModules =
  #   entrypoint1.hmModules
  #   ++ [entrypoint3, entrypoint4];
  # 
  #  initActions = [
  #   {
  #     action = "copy";
  #     source = "./pathToFileOrDirectoryToCopy";
  #     destination = [ "destionationPathsRelativToHome" ];
  #   }
  #   {
  #     action = "write-file";
  #     content = ''
  #       Content of the file to create
  #     '';
  #     destination = [ "destionationPathsRelativToHome" ];
  #   }
  # ];
  #  
  # };

in

{

  # COMPOSED COMPONENT IMPORTS ================================================
  #
  # Import composed components. Imports can be direct (static) or conditional.
  #
  #

  # TODO: Add components

  # Example:
  # imports =
  # 
  # ----------------------------------------- componentName
  #
  #   if desktop == "gnome" then
  #     [ (composeComponent componentName) ]
  #
  #   else [];
  #
  
}
```

