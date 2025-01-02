return {
  -- Add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      styles = {
        sidebars = "transparent",
        float = "transparent",
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Change neo-tree hidden
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hiddencount = true,
          hide_dotfiles = false,
          hidegitignored = true,
          hidebyname = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          nevershow = {},
        },
      },
    },
  },

  -- Add russian
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require("langmapper").setup({})
    end,
  },
}
