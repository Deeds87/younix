# file: system/core/home-manager/xdg-user-dirs.nix

# #############################################################################
#
# Description:
# Systemd service to set xdg-user-dirs to the right locale.
#
# #############################################################################

{ pkgs, ... }:

{

  # Install package
  home.packages = with pkgs; [

    xdg-user-dirs

  ];

  # Service to run on session start
  systemd.user.services.xdg-user-dirs-update = {
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
