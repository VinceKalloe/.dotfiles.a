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

  -- Configure noice with standard cmdline
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = {},
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        -- longmessagetosplit = true, -- long messages will be sent to a split
        -- increname = false, -- enables an input dialog for inc-rename.nvim
        -- lspdocborder = false, -- add a border to hover docs and signature help
      },
    },
  },
}
