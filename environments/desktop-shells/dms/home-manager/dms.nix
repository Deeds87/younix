# file: environments/desktop-shells/dms/home-manager/dms.nix

# #############################################################################
#
# Description:
# Dank Materials Shell Home-Manager module.
#
# #############################################################################

{
  osConfig,
  options,
  lib,
  ...
}:

let

  # Whether Yazi is available and enabled in the current configuration
  yaziEnabled =
    lib.hasAttrByPath [ "programs" "yazi" "enable" ] options && osConfig.programs.yazi.enable;

in

{

  # XDG SETTINGS ==============================================================

  # Yazi --------------------------------------------------
  # Modified desktop entry for yazi TUI filemanager
  #
  # This modification is required when yazi is selected as
  # the default file manager in DMS settings.
  # It is also required to start yazi from launcher.
  # (Requires xdg-terminal-exec package)

  xdg.desktopEntries.yazi = lib.mkIf yaziEnabled {
    name = "Yazi File Manager";
    icon = "yazi";
    comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
    terminal = false;
    exec = "xdg-terminal-exec yazi %f";
    type = "Application";
    mimeType = [ "inode/directory" ];
    categories = [
      "System"
      "FileManager"
      "FileTools"
      "ConsoleOnly"
    ];
  };
}
