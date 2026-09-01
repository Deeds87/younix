# file: home.nix

# #############################################################################
#
# Description:
# This file configures Home-Manager.
#
# #############################################################################

{ config, ... }:

let
  username = config.younix.user.username;

  stateVersion = config.younix.system.stateVersion;
in

{

  home-manager = {

    # Uses the system-wide 'pkgs' set to ensure consistency
    # with overlays and custom packages
    useGlobalPkgs = true;

    # Install Home-Manager packages through the NixOS user profile.
    useUserPackages = true;

    # Creates backup file of existing config (e.g. configFile.toml.backup)
    backupFileExtension = "backup";

    users.${username} = {

      # Username of the Home-Manager user
      home.username = username;

      # Path to the home directory of the managed user
      home.homeDirectory = "/home/${username}";

      # Home-Manager state version.
      # This is shared with the NixOS state version through the youNIX configuration.
      home.stateVersion = stateVersion;

      # Enables Home-Manager
      programs.home-manager.enable = true;

      # Imports the fallback Home-Manager application aggregator.
      #
      # When using youNIX, the application composer selects the desired
      # application modules instead. This aggregator can still be used
      # independently when youNIX is not used.
      imports = [
        # Create an application aggregator .(/software/default.nix)
      ];
    };
  };

}
