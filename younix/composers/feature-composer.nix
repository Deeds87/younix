# file: composers/feature-composer.nix

# #############################################################################
#
# Description:
# Composes optional system features based on the YouNIX feature settings.
#
# #############################################################################

{ ... }:

let

  # Importing youNIX configuration to get access to the settings.
  younixSettings = import ../../younix-config.nix;

  # VARIABLES =================================================================
  #
  # Composerwide variables can be added here.
  #
  #

  username = younixSettings.user.username;

  virtualization = younixSettings.features.virtualization;

  # HELPER ====================================================================
  #
  # Helper functions can be added here.
  #
  #

  # Compose a component consisting of NixOS modules, Home-Manager modules and
  # initial one-time actions.
  composeComponent =
    {
      nixosModules ? [ ],
      hmModules ? [ ],
      initActions ? [ ],
    }:
    {
      imports = nixosModules;
      home-manager.users.${username}.imports = hmModules;
      younix.initActions = initActions;
    };

  # COMPONENT SETUP ===========================================================
  #
  # Each component to compose has to be setup here. A component setup contains
  # context-aware module lists as well as a list of initial actions.
  #
  #

  # ---------------------------------------- Virtualization

  # Import entrypoints
  qemu = import ../../features/virtualization/qemu;
  virtualbox = import ../../features/virtualization/virtualbox;
  virt-manager = import ../../software/gui/virt-manager;

  # Create context-aware module lists
  virtualizationComponent = {
    nixosModules =
      (if builtins.elem "qemu" virtualization.backends then qemu.nixosModules else [ ])
      ++ (if builtins.elem "virtualbox" virtualization.backends then virtualbox.nixosModules else [ ])
      ++ (
        if builtins.elem "virt-manager" virtualization.frontends then virt-manager.nixosModules else [ ]
      );

    hmModules =
      (if builtins.elem "qemu" virtualization.backends then qemu.hmModules else [ ])
      ++ (if builtins.elem "virtualbox" virtualization.backends then virtualbox.hmModules else [ ])
      ++ (if builtins.elem "virt-manager" virtualization.frontends then virt-manager.hmModules else [ ]);

    initActions = [ ];
  };

in

{

  # COMPOSED COMPONENT IMPORTS ================================================
  #
  # Import composed components. Imports can be direct (static) or conditional.
  #
  #

  imports =

    # -------------------------------------- Virtualization

    if virtualization.mode != "none" then
      [ (composeComponent virtualizationComponent) ]

    # ------------------------------------------------ None

    else
      [ ];

}
