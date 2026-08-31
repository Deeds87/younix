# file: system/maintenance/nixos/updates.nix

# #############################################################################
#
# Description:
# Maintenance features related to updates.
#
# #############################################################################

{ pkgs, ... }:

{

  # DEPENDENCIES ==============================================================

  environment.systemPackages = with pkgs; [
    nvd
  ];

  # NVD DIFF ==================================================================

  # Shows changed versions of packages on every rebuild.
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };

  # FIRMWARE UPDATES ==========================================================

  services.fwupd.enable = true;

}
