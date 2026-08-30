# file: younix/overlays/default.nix

# #############################################################################
#
# Description:
# Collects and composes all YouNIX overlays.
#
# #############################################################################

final: prev:

prev.lib.composeManyExtensions [
  (import ./upstream-fixes.nix)
] final prev
