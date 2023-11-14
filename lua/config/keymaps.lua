-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local options = { remap = false, silent = true }

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- quick access to the config file
map("n", "<leader>rc", ":e ~/.config/nvim/init.vim <cr>", { desc = "Config file", remap = false })

-- select all
map("n", "å", "gg<S-v>G", { desc = "Select all", remap = false }) -- option + a

-- use ; as :
map("n", ";", ":", options)

-- use jj to switch from i to n mode
map("i", "jj", "<esc>", options)

-- quick movement
map("n", "J", "15j", options)
map("n", "K", "15k", options)
map("v", "H", "g^", options)
map("n", "H", "g^", options)
map("v", "L", "g$", options)
map("n", "L", "g$", options)

-- replace the highlighted text with content from clip board.
map("n", "d", '"zd', options)
map("v", "d", '"zd', options)
map("n", "x", '"zx', options)
map("v", "x", '"zx', options)
map("v", "p", '"_dP', options)
map("x", "<leader>p", '"_dp', options) -- paste without replacing the content in current register.

-- Move to window using the <ctrl> hjkl keys
map("n", "<leader>h", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>j", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>k", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>l", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "∆", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "˚", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "∆", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "˚", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
if Util.has("bufferline.nvim") then
  map("n", "{", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "}", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "{", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "}", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<leader><CR>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "=", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "=", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "=", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "-", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "-", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "-", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", require("lazyvim.util").format.toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle.diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- terminal
map("n", "<leader>t", ":ToggleTerm<cr>",{desc="Toggle terminal"})

-- Terminal Mappings
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>cw", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader><leader>j", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader><leader>l", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><leader>0", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><leader>1", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "ti", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "+", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "_", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- keymaps for lsp
map("n", "<leader>dc", "<cmd>lua vim.lsp.buf.declaration()<CR>", options)
map("n", "<leader>df", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
map( "n", "<leader>dt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
map("n", "<leader>ov", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
map("n", "<leader>ip", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
map("n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>", options)
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)

-- Diagnostics
map("n", "<leader>dg", "<cmd>lua vim.diagnostic.open_float()<CR>", options)
map("n", "<leader>dk", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', options)
map("n", "<leader>dj", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', options)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
