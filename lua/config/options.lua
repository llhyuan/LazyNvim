-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.matchtime = 10

-- Enable break indent
vim.opt.breakindent = true

-- terminal
vim.opt_global.shell = "/bin/zsh"

-- tabs
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.smartindent = true

vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "+",
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Setup sonokai colortheme
vim.g.sonokai_style = "andromeda"
vim.g.sonokai_better_performance = 1

vim.g.gruvbox_material_foreground = "mix"

-- Disables automatic commenting on newline
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})
