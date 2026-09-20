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
    # Quit all
    {
      mode = "n";
      key = "<leader>q";
      action = ":confirm qa<CR>";
      options = {
        desc = "Quit all";
      };
    }

    # Write
    {
      mode = "n";
      key = "<leader>w";
      action = ":w<CR>";
      options = {
        desc = "Save all buffers";
        silent = true;
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

    # WINDOWS =================================================================

    # ------------------------------------------ Navigation
    # Window left
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        silent = true;
      };
    }

    # Window down
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        silent = true;
      };
    }

    # Window up
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        silent = true;
      };
    }

    # Window right
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        silent = true;
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
