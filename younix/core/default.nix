# file: younix/core/default.nix

# #############################################################################
#
# Description:
# YouNIX core aggregator.
#
# #############################################################################

{ ... }:

{

  imports = [

    # YouNIX core module ----------------------------------
    ./module.nix

    # YouNIX initActions ----------------------------------
    ./init-actions.nix

  ];

}
