# file: system/core/nixos/boot.nix

# #############################################################################
#
# Description:
# The boot module configures the system boot process.
#
# #############################################################################

{ config, pkgs, ... }:

let

  bootGenerationLimit = config.younix.maintenance.bootMenuEntries;

  kernel = config.younix.system.kernel;

  kernelPackages = {
    lts = pkgs.linuxPackages;
    latest = pkgs.linuxPackages_latest;
  };

in

{

  boot.loader.systemd-boot = {
    # Enable systemd boot
    enable = true;

    # Limit of NixOS generations shown in the boot menu
    configurationLimit = bootGenerationLimit;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # Set kernel packages to be used
  boot.kernelPackages = kernelPackages.${kernel};

}
