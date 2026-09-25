# file: core/module.nix

# #############################################################################
#
# Description:
# This module imports the user-defined youNIX settings into the NixOS module
# system, making them available as `config.younix.*` in NixOS and as
# 'osConfig.younix.*' in Home-Manager. It also imports the youNIX init-actions
# into Home-Manager.
#
# #############################################################################

{ ... }:

let
  younixSettings = import ./../../younix-config.nix;
  username = younixSettings.user.username;
  repositoryPath = younixSettings.user.configPath;
in

{

  config = {

    # Creates younix namespace
    younix = younixSettings;

    # Set local Repository ownership
    systemd.tmpfiles.settings."younix-repository" = {
      "${repositoryPath}".Z = {
        user = username;
        group = "users";
      };
    };

    # Home-Manager ----------------------------------------
    home-manager.users.${username}.imports = [

      # Import initActions
      ./init-actions.nix

    ];

  };

}
