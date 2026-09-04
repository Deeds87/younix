# file: software/tui/yazi/nixos/yazi.nix

# #############################################################################
#
# Description:
# Yazi - TUI file-manager (NixOS module)
#
# #############################################################################

{ pkgs, ... }:

{

  # DEPENDENCIES ==============================================================

  # ----------------------------------------- Display icons
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [

    # ----------------------------------------- Integration
    xdg-terminal-exec # desktop entry

    # ------------------------------------------ Navigation
    fzf # file subtree navigation
    zoxide # navigate historical directories

    # ------------------------------------------- Searching
    ripgrep # file content search
    fd # file search

    # ---------------------------------------- File preview
    jq # json preview
    poppler # pdf preview
    resvg # svg preview
    imagemagick # image preview
    ffmpeg # video thumbnails

    # ------------------------------------------------ Misc
    wl-clipboard # wayland clipboard
    _7zz # achiver utility
  ];

  xdg.desktopEntries.yazi = {
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
