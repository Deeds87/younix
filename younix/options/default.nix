# file: younix/options/default.nix

# #############################################################################
#
# Description:
# Aggreates the youNIX options system.
#
# #############################################################################

{ ... }:

{

  imports = [

    # Options Schema --------------------------------------
    ./options.nix

    # Options Assertions ----------------------------------
    ./options-assertions.nix

  ];

}
