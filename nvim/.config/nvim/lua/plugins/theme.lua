return {
      -- The short name is just the GitHub "owner/repo"
      {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
          vim.cmd.colorscheme("catppuccin")
        end,
      }
    }