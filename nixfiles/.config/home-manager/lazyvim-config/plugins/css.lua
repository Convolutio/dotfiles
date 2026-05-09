return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = function()
      require("colorizer").setup({
        filetypes = { ".css", ".scss" },
        user_default_options = {
          css = true,
          css_fn = true,
          rgba_fn = true,
        },
      })
    end,
  },
}
