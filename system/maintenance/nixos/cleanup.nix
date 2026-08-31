# file: system/maintenance/nixos/cleanup.nix

# #############################################################################
#
# Description:
# Maintenance features around system cleanup.
#
# #############################################################################

{ config, ... }:

let

  # Garbage collection variables from youNIX
  gcEnabled = config.younix.maintenance.garbageCollection.enable;
  gcSchedule = config.younix.maintenance.garbageCollection.schedule;
  gcRetention = config.younix.maintenance.garbageCollection.retention;

in

{

  # GARBAGE COLLECTION ========================================================

  nix.gc = {
    automatic = gcEnabled;
    dates = gcSchedule;
    options = "--delete-older-than ${gcRetention}";
    # Persist the last-run timestamp so missed GC runs are executed after reboot.
    persistent = true;
  };

  # STORE OPTIMIZATION ========================================================

  # Automatically optimize the Nix store to reduce disk usage.
  nix.settings.auto-optimise-store = true;

}
