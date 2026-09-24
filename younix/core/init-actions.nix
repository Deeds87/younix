# file: core/init-actions.nix

# #############################################################################
#
# Description:
# Provides inital actions on files and directories. All actions work on the
# user /home directory.
#
# Existing user data is never overwritten.
#
# #############################################################################

{
  lib,
  osConfig,
  ...
}:

let

  cfg = osConfig.younix.initActions;

  initAction =
    item:

    # Copy action -----------------------------------------

    if item.action == "copy" then
      lib.concatMapStringsSep "\n" (destination: ''
        mkdir -p "$HOME/${destination}"

        if [ -d "${item.source}" ]; then
          cp -rn --no-preserve=mode "${item.source}/." "$HOME/${destination}/"
        else
          if [ ! -e "$HOME/${destination}/$(basename "${item.source}")" ]; then
            cp --no-preserve=mode "${item.source}" "$HOME/${destination}/"
          fi
        fi

        chmod -R u+rwX "$HOME/${destination}"
      '') item.destination

    # Create-Directory action -----------------------------

    else if item.action == "create-directory" then
      lib.concatMapStringsSep "\n" (destination: ''
        if [ ! -d "$HOME/${destination}" ]; then
          mkdir -p "$HOME/${destination}"
        fi
      '') item.destination

    # Write-File action -----------------------------------

    else if item.action == "write-file" then
      lib.concatMapStringsSep "\n" (destination: ''
            if [ ! -e "$HOME/${destination}" ]; then
              mkdir -p "$(dirname "$HOME/${destination}")"
              cat > "$HOME/${destination}" <<'EOF'
        ${item.content}
        EOF
              chmod u+rw "$HOME/${destination}"
            fi
      '') item.destination

    # Not defined action error ----------------------------

    else
      throw "Unknown initActions action: ${item.action}";

in

{

  home.activation.init-younix-actions =
    lib.mkIf (cfg != [ ])

      (
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${lib.concatMapStringsSep "\n" initAction cfg}
        ''
      );

}
