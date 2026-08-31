# file: system/users/nixos/init-user.nix

# #############################################################################
#
# Description:
# Init user configuration.
#
# #############################################################################

{ config, pkgs, ... }:

let

  user = config.younix.user;

in

{

  users.users.${user.username} = {
    isNormalUser = true;
    description = user.fullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    # Default shell
    shell = pkgs.zsh;
  };

}
