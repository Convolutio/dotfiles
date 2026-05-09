return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    ---@class snacks.dashboard.Config
    ---@field sections snacks.dashboard.Section
    ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
    dashboard = {
      preset = {
        header = [[
░█████╗░░█████╗░████████╗░░░███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
██╔══██╗██╔══██╗╚══██╔══╝░░░████╗░██║██║░░░██║██║████╗░████║
██║░░██║██║░░╚═╝░░░██║░░░░░░██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
██║░░██║██║░░██╗░░░██║░░░░░░██║╚████║░╚████╔╝░██║██║╚██╔╝██║
╚█████╔╝╚█████╔╝░░░██║░░░██╗██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
░╚════╝░░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝]],
      },
      sections = {
        { section = "header", pane = 2 },
        {
          section = "terminal",
          cmd = "chafa ~/Pictures/logo_sticker.png --format symbols --symbols -dot --size 60x60; sleep .1",
          padding = 1,
          height = 30,
        },
        {
          pane = 2,
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
