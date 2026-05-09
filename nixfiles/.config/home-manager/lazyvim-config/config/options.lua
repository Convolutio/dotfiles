-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.textwidth = 79
opt.colorcolumn = "+1"

opt.wrap = true

-- `+y` for system yank, `y` for in session yank
opt.clipboard = ""

-- remove format on file save
vim.g.autoformat = false

-- French and English
opt.spell = true
opt.spelllang = { "en_us", "fr" }
