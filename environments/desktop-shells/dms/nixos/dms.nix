# file: environments/desktop-shells/dms/nixos/dms.nix

# #############################################################################
#
# Description:
# Dank Material Shell NixOS module
#
# #############################################################################

{
  inputs,
  pkgs,
  ...
}:

{

  # DEPENDENCIES ==============================================================

  environment.systemPackages = with pkgs; [

    xdg-terminal-exec # Select default apps in GUI
    valent # dankKDEConnect backend

  ];

  # DMS MODULE ================================================================

  imports = [ inputs.dms-plugin-registry.nixosModules.default ];

  programs.dms-shell = {

    # --------------------------------------- Core settings
    enable = true;

    # Use package from flake input
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # --------------------------------------------- Plugins
    plugins = {
      dankKDEConnect.enable = true;
    };

  };

}
