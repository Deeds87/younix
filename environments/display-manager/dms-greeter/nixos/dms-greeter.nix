# file: environments/display-manager/dms-greeter/nixos/dms-greeter.nix

# #############################################################################
#
# Description:
# Dank Greeter, a display-manager based on greetd.
#
# #############################################################################

{ config, ... }:

let

  username = config.younix.user.username;

in

{

  services.displayManager.dms-greeter = {
    enable = true;
    compositor = {
      name = "niri"; # Required. Can be also "hyprland" or "sway"
      # customConfig = ''
      # Optional custom compositor configuration
      # '';
    };

    # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
    configHome = "/home/${username}";

    # Custom config files for non-standard config locations
    # configFiles = [
    #   "/home/yourusername/.config/DankMaterialShell/settings.json"
    # ];

    # Save the logs to a file
    # logs = {
    #   save = true;
    #   path = "/tmp/dms-greeter.log";
    # };

  };

}
