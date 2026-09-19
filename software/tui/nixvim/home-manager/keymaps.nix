# file: software/tui/nixvim/home-manager/keymaps.nix

# #############################################################################
#
# Description:
# All global or non plugin specific keymaps.
# (Keymaps related to a plugin are specified in the plugin configuration.)
#
# #############################################################################

{ ... }:

{

  programs.nixvim.keymaps = [

    # GENERAL =================================================================

    # --------------------------------------- Save and quit
    # Quit (all)
    {
      mode = "n";
      key = "<leader>qa";
      action = ":confirm qa<CR>";
      options = {
        desc = "Quit all";
      };
    }
    {
      mode = "n";
      key = "<leader>qw";
      action = ":confirm q<CR>";
      options = {
        desc = "Quit current window";
      };
    }

    # Write
    {
      mode = "n";
      key = "<leader>wa";
      action = ":wa<CR>";
      options = {
        desc = "Save all buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>wb";
      action = ":w<CR>";
      options = {
        desc = "Save current buffer";
      };
    }

    # BUFFERS =================================================================

    # ------------------------------------------ Navigation
    # Next buffer
    {
      mode = "n";
      key = "<tab>";
      action = ":bnext<CR>";
      options = {
        silent = true;
        desc = "Go to next buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = ":bnext<CR>";
      options = {
        silent = true;
        desc = "Go to next buffer";
      };
    }

    # Previous buffer
    {
      mode = "n";
      key = "<S-tab>";
      action = ":bprevious<CR>";
      options = {
        silent = true;
        desc = "Go to previous buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = ":bprevious<CR>";
      options = {
        silent = true;
        desc = "Go to previous buffer";
      };
    }

    # -------------------------------------------- Controls
    # Close buffer
    {
      mode = "n";
      key = "<leader>bd";
      action = ":confirm bdelete<CR>";
      options = {
        desc = "Close current buffer";
      };
    }

    # MOVE LINES & SELCTIONS ==================================================

    # ------------------------------------------ Move lines
    # Normal Mode
    {
      mode = "n";
      key = "<M-Up>";
      action = ":m .-2<CR>==";
      options = {
        desc = "Move line up";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<M-Down>";
      action = ":m .+1<CR>==";
      options = {
        desc = "Move line down";
        silent = true;
      };
    }

    # Insert Mode
    {
      mode = "i";
      key = "<M-Up>";
      action = "<Esc>:m .-2<CR>==gi";
      options = {
        desc = "Move line up";
        silent = true;
      };
    }

    {
      mode = "i";
      key = "<M-Down>";
      action = "<Esc>:m .+1<CR>==gi";
      options = {
        desc = "Move line down";
        silent = true;
      };
    }

    # ------------------------------------- Move selections
    # Move selection up
    {
      mode = "v";
      key = "<M-Up>";
      action = ":m '<-2<CR>gv=gv";
      options = {
        desc = "Move selection up";
        silent = true;
      };
    }

    # Move selection down
    {
      mode = "v";
      key = "<M-Down>";
      action = ":m '>+1<CR>gv=gv";
      options = {
        desc = "Move selection down";
        silent = true;
      };
    }

  ];

}
