# file: software/gui/synology-drive-client/home-manager/synology-drive-client.nix

# #############################################################################
#
# Description:
# Synology Drive Client
#
# #############################################################################

{
  pkgs,
  lib,
  ...
}:

{

  home.packages = with pkgs; [
    synology-drive-client
  ];

  # https://github.com/NixOS/nixpkgs/issues/310505
  # Synology Drive caches its installation path outside the Nix store.
  # Because the Nix store path changes after every package update,
  # the cached application directory must be removed whenever the
  # installed package changes.

  home.activation.synologyDriveCacheCleanup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    SYNOLOGY_APP_DIR="$HOME/.SynologyDrive/SynologyDrive.app"
    CURRENT_STORE_PATH="${pkgs.synology-drive-client}"
    STORE_PATH_MARKER="$HOME/.SynologyDrive/.synology-drive-store-path"

    if [ -d "$SYNOLOGY_APP_DIR" ]; then
      STORED_PATH=""

      if [ -f "$STORE_PATH_MARKER" ]; then
        STORED_PATH=$(cat "$STORE_PATH_MARKER")
      fi

      if [ "$STORED_PATH" != "$CURRENT_STORE_PATH" ]; then
        echo "Synology Drive: detected changed Nix store path, clearing cached application directory..."
        rm -rf "$SYNOLOGY_APP_DIR"
      fi
    fi

    mkdir -p "$(dirname "$STORE_PATH_MARKER")"
    echo "$CURRENT_STORE_PATH" > "$STORE_PATH_MARKER"
  '';

}
