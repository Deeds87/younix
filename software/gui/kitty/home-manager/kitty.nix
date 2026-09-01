# file: software/gui/kitty/home-manager/kitty.nix

# #############################################################################
#
# Description:
# Kitty Terminal Emulator
#
# #############################################################################

{ ... }:

{

  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    extraConfig = ''
      include ./dank-theme.conf
      include ./dank-tabs.conf

      allow_remote_control yes

      background_opacity 0.85
      background_blur 1
      draw_minimal_borders yes
      hide_window_decorations yes
      cursor_trail 1

      window_padding_width 8
      single_window_padding_width -1
      confirm_os_window_close 0
    '';

  };

}
