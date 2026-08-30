# file: younix/overlays/upstream-fixes.nix

# #############################################################################
#
# Description:
# Temporary fixes for packages that have already been fixed upstream but are not
# yet available in the pinned nixpkgs revision.
#
# Remove overrides once the corresponding nixpkgs update reaches the channel.
#
# #############################################################################

final: prev:

{
  # NIRI ================================================================ FIXED

  # niri currently requires libdisplay-info < 0.4.0 because the vendored
  # libdisplay-info-sys crate still rejects version 0.4.x.
  #
  # Temporary workaround for nixpkgs#545480.
  # Fixed by:
  #   - nixpkgs#546004 (niri)
  # Remove after updating to a nixpkgs revision containing those PRs.

  # libdisplay-info_0_3 = prev.libdisplay-info.overrideAttrs (_old: {
  #   version = "0.3.0";
  #
  #   src = prev.fetchFromGitLab {
  #     domain = "gitlab.freedesktop.org";
  #     owner = "emersion";
  #     repo = "libdisplay-info";
  #     rev = "0.3.0";
  #     hash = "sha256-nXf2KGovNKvcchlHlzKBkAOeySMJXgxMpbi5z9gLrdc=";
  #   };
  # });
  #
  # niri = prev.niri.override {
  #   libdisplay-info = final.libdisplay-info_0_3;
  # };

}
