# file: system/core/nixos/printing.nix

# #############################################################################
#
# Description:
# The printing module configures printing capabilities.
#
# #############################################################################

{ ... }:

{

  # Enable cups printing service
  services.printing.enable = true;

}
