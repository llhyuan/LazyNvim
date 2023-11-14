-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight yanked text
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
---Highlight the texts when you yanked
au("TextYankPost", {
  group = ag("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- To change the rainbow color scheme
-- au("ColorScheme", {
--   group = ag("rainbow", {}),
--   pattern = "*.*",
--   callback = function()
--     vim.cmd([[highlight RainbowDelimiterRed ctermbg=0 guibg="#C83F39"]])
--     vim.cmd([[highlight RainbowDelimiterOrange ctermbg=0 guibg="#F07F5E"]])
--     vim.cmd([[highlight RainbowDelimiterYellow ctermbg=0 guibg="#F8De7E"]])
--     vim.cmd([[highlight RainbowDelimiterGreen ctermbg=0 guibg="#93c572"]])
--     vim.cmd([[highlight RainbowDelimiterViolet ctermbg=0 guibg="#B768A2"]])
--   end,
-- })
