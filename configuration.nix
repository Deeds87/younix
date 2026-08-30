# file: configuration.nix

# ##############################################################################
#
#                              WELCOME TO youNIX!
#
#
# If you are seeing this for the first time, you are probably here because you
# expected this file to be the entry point for a NixOS configuration.
# While you are naturally correct with this assumption, since you are using
# youNIX, the responsibilities have shifted slightly.
#
# youNIX provides you with a configuration file (younix-config.nix) that allows
# you to make the most basic settings for your system, almost as you are used
# to from configuration files on other Linux distributions. So take a look
# there first.
# As your knowledge about how NixOS works grows, you can completely remove this
# abstraction layer, or you can keep it and enjoy its benefits even as an
# advanced user.
#
# I wish you lots of fun with youNIX.
#
# ##############################################################################

{ ... }:

let

  # youNIX settings:
  # The following line imports all youNIX settings from `younix-config.nix` and
  # makes them accessible.
  younixSettings = import ./younix-config.nix;

  # NixOS and Home-Manager state version originally used when the system
  # was installed. It is read from 'younix-config.nix'.
  stateVersion = younixSettings.system.stateVersion;

in

{

  # SYSTEM STATE VERSION ======================================================

  # Defines the NixOS version whose default values and compatibility behavior
  # should be used for this system.
  #
  # This does not pin the system to this NixOS version and does not control
  # which nixpkgs version is used.
  #
  # DO NOT CHANGE UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = stateVersion;

  imports = [

    # BASIC SYSTEM ============================================================

    # youNIX module:
    # The youNIX module creates an abstraction layer for the most common
    # settings users may change from time to time. NixOS beginners get an
    # easy to use entry point and more advanced users get a bit more of
    # convenience. This module can be adopted or removed depending on
    # skills and will.
    ./younix/core
    ./younix/options
    ./younix/composers

    # Hardware configuration:
    # This file declares the hardware configuration of the current machine.
    # In most cases it does not need to be touched. When you used `younix-install.sh'
    # your hardware-configuration.nix was moved to this repo automatically,
    # otherwise make sure it's been present in the repo's root directory.
    ./hardware-configuration.nix

    # Home-Manager configuration:
    # This file configures the Home-Manager integration.
    # If you use youNIX the configuration values are read from
    #'younix-config.nix' automatically.
    ./home.nix

  ];

}
