# file: composers/environment-composer.nix

# #############################################################################
#
# Description:
# Composes desktop environments and desktop stacks for window managers.
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

  desktop = younixSettings.environment.desktop;
  screenshotPath = younixSettings.environment.screenshotPath;
  keyboard = {
    layout = younixSettings.environment.keyboard.layout;
    variant = younixSettings.environment.keyboard.variant;
    options = "grp:ctrls_toggle";
  };

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

  # -------------------------------------------------- Niri

  # Import entrypoints
  niri = import ./../../environments/desktops/niri;
  dms = import ./../../environments/desktop-shells/dms;
  dms-greeter = import ./../../environments/display-manager/dms-greeter;

  # Create context aware module lists
  niriEnvironment = {
    nixosModules = niri.nixosModules ++ dms.nixosModules ++ dms-greeter.nixosModules;

    hmModules = niri.hmModules ++ dms.hmModules ++ dms-greeter.hmModules;

    initActions = [
      # External niri settings
      {
        action = "copy";
        source = ./../../environments/desktops/niri/external-configs;
        destination = [ ".config/niri" ];
      }

      # External DMS settings
      {
        action = "copy";
        source = ./../../environments/desktop-shells/dms/external-configs/DankMaterialShell;
        destination = [ ".config/DankMaterialShell" ];
      }

      {
        action = "copy";
        source = ./../../environments/desktop-shells/dms/external-configs/MimeApps;
        destination = [ ".config" ];
      }

      # Screenshot path
      {
        action = "write-file";
        content = ''
          screenshot-path "${screenshotPath}/Screenshot from %Y-%m-%d %H-%M-%S.png"
        '';
        destination = [ ".config/niri/younix/screenshot-path.kdl" ];
      }

      # Input settings
      {
        action = "write-file";
        content = ''
            input {
            keyboard {
              xkb {
                layout "${keyboard.layout}"
                variant "${keyboard.variant}"
                options "${keyboard.options}"
              }
            }
            touchpad {
              tap
              natural-scroll
              disabled-on-external-mouse
            }
          }

        '';
        destination = [ ".config/niri/younix/input.kdl" ];
      }
    ];
  };

  # ------------------------------------------------- Gnome

  # Import entrypoints
  gnome = import ./../../environments/desktops/gnome;
  gdm = import ./../../environments/display-manager/gdm;

  # Create context aware module lists
  gnomeEnvironment = {
    nixosModules = gnome.nixosModules ++ gdm.nixosModules;

    hmModules = gnome.hmModules ++ gdm.hmModules;

    initActions = [ ];
  };

  # --------------------------------------------------- KDE

  # Import entrypoints
  kde = import ./../../environments/desktops/kde;
  plasma-login = import ./../../environments/display-manager/plasma-login;

  # Create context aware module lists
  kdeEnvironment = {
    nixosModules = kde.nixosModules ++ plasma-login.nixosModules;

    hmModules = kde.hmModules ++ plasma-login.hmModules;

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

    # ------------------------------------------------ Niri

    if desktop == "niri" then
      [ (composeComponent niriEnvironment) ]

    # ----------------------------------------------- Gnome

    else if desktop == "gnome" then
      [ (composeComponent gnomeEnvironment) ]

    # ------------------------------------------------- KDE

    else if desktop == "kde" then
      [ (composeComponent kdeEnvironment) ]

    # else
    else
      [ ];

}
