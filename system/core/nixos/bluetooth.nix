# file: system/core/nixos/bluetooth.nix

# #############################################################################
#
# Description:
# The bluetooth module configures bluetooth on the system.
#
# #############################################################################

{ ... }:

{

  hardware.bluetooth = {
    # Enable bluetooth
    enable = true;

    # Enable bluetooth on system boot
    powerOnBoot = true;

    # Add additional bluetooth settings
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

}
