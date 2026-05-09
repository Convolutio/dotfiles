return {
  -- specify the flavour for dark and light mode
  {
    "catppuccin/nvim",
    opts = {
      flavour = "auto",
      background = {
        dark = "mocha",
        light = "latte",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.special.bufferline").get_theme()
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- Autoswitch with system's chosen appearance
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 3000,
      fallback = "light",
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
      end,
    },
  },
}
