# file: younix/composers/default.nix

# #############################################################################
#
# Description:
# Aggregates all YouNIX composers.
#
# #############################################################################

{ ... }:

{
  imports = [

    ./environment-composer.nix
    ./extras-composer.nix
    ./feature-composer.nix
    ./system-composer.nix
    ./cli-composer.nix
    ./gui-composer.nix
    ./tui-composer.nix

  ];
}
