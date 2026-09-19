# file: software/tui/nixvim/home-manager/nixvim.nix

# #############################################################################
#
# Description:
# Nixvim main configuration.
#
# #############################################################################

{ inputs, pkgs, ... }:

let

  # ------------------------------------------ Base46 theme
  base46 = pkgs.vimUtils.buildVimPlugin {
    pname = "base46";
    version = "unstable";
    src = inputs.base46;
    doCheck = false;
  };
in

{

  # IMPORTS ===================================================================

  imports = [

    # --------------------------------------------- Options
    ./options.nix
    # --------------------------------------------- Autocmd
    ./autocmd.nix
    # -------------------------------------- Global keymaps
    ./keymaps.nix
    # --------------------------------------------- Plugins
    ./plugins

  ];

  # CONFIGURATION =============================================================

  programs.nixvim = {

    enable = true;

    # --------------------------------------- Extra plugins
    extraPlugins = [ base46 ];

    # ---------------------------------------------- Themes
    colorschemes.base16.enable = false;
    colorschemes.catppuccin.enable = false;
    colorschemes.tokyonight.enable = false;
    colorscheme = "dms";

    # ------------------------------------------ Leader key
    globals.mapleader = " ";

  };

}
