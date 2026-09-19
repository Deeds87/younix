# file: software/tui/nixvim/home-manager/options.nix

# #############################################################################
#
# Description:
# All vim options are set here.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    opts = {

      # ------------------------------------------- General
      # Confirm if data could be lost
      confirm = true;

      # ------------------------------------------------ UI
      cursorline = true; # Highlight current line
      signcolumn = "yes"; # Show signcolumn on the left
      termguicolors = true; # Use truecolors/rgb-colors
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      inccommand = "split";

      list = true; # Show whitespace characters
      listchars = {
        tab = "» ";
        trail = "+";
        nbsp = "␣";
        space = "·";
        lead = " ";
        leadmultispace = " ";
      };

      # -------------------------------------------- Search
      ignorecase = true; # Case insensitve search
      smartcase = true; # Case sensitive search when using a capital letter
      hlsearch = true; # Highlight all search results
      incsearch = true; # Show search results while typing

      # ------------------------------------------- Editing
      scrolloff = 10; # Lines to keep visible while scrolling
      sidescrolloff = 10; # Columns to keep visible while scrolling
      wrap = false; # Wrap long lines

      shiftwidth = 4; # Indentation
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;

      # -------------------------------------------- Splits
      splitbelow = true; # New hsplit below
      splitright = true; # New vsplit on the right

    };

  };

}
