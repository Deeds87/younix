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

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # ------------------------------------ Feature settings
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)

    # --------------------------------------------- Plugins
    plugins = {
      dankKDEConnect.enable = true;
    };

  };

}
