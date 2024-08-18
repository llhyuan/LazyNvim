-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local options = { noremap = true, silent = true }

local map = vim.keymap.set

-- quick access to the config file
map("n", "<leader>rc", ":e ~/.config/nvim/init.vim <cr>", { desc = "Config file", remap = false })

-- select all
map("n", "å", "gg<S-v>G", { desc = "Select all", remap = false }) -- option + a

-- use ; as :
-- map("n", ";", ":", options)

-- use jj to switch from i to n mode
map("i", "jj", "<esc>", options)

-- quick movement
-- <CTRL-u> half screen up
-- <CTRL-d> half screen up
-- CTRL-e (scroll the screen one line up)
-- CTRL-y (scroll the screen one line down)
-- CTRL-f (To scroll by a full screen)
-- CTRL-b (To scroll backward by a full screen)
-- zz to move the line under the cursor to the middle of the screen
-- zt to ... to the top of the scteen
-- zb to ... to the bottom of the scteen
map("v", "H", "^", options)
map("n", "H", "^", options)
map("v", "L", "$", options)
map("n", "L", "$", options)

-- replace the highlighted text with content from clip board.
--map("n", "d", '"zd', options)
--map("v", "d", '"zd', options)
map("n", "x", '"zx', options)
map("v", "x", '"zx', options)
map("v", "p", '"_dP', options)
map("x", "<leader>p", '"_dp', options) -- paste without replacing the content in current register.

-- Navigate window using the <ctrl> hjkl keys

--map("n", "<leader>h", "<C-w>h", { desc = "Go to left window", remap = true })
--map("n", "<leader>j", "<C-w>j", { desc = "Go to lower window", remap = true })
--map("n", "<leader>k", "<C-w>k", { desc = "Go to upper window", remap = true })
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

-- new file
--map("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })

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
map("n", "<leader>ud", function () Util.toggle('diagnostic') end, {desc='Toggle diagnostic'} )

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
map("n", "<leader>gg", ":LazyGit<cr>", { desc = "Lazygit in a float term" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- terminal
map("n", "<leader>t", ":ToggleTerm<cr>",{desc="Toggle terminal"})
-- <number><leader>t open up a different terminal, with a different id indicated by the <number>. 

-- Terminal Mappings
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Window Navigating: intergrated with tmux 
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<cr>", { desc = "Go to lower window" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { desc = "Go to upper window" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { desc = "Go to right window" })
map("t", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd> TmuxNavigateDown<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { desc = "Go to right window" })


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
map("n", "gr", require('telescope.builtin').lsp_references, {desc= 'Go to references'})
map("n", "gd", require('telescope.builtin').lsp_definitions, {desc= 'Go to definition'})
map( "n", "gt", require('telescope.builtin').lsp_type_definitions, {desc= 'Go to type definition'})
map("n", "K", vim.lsp.buf.hover, {desc= 'Hover'})
map("n", "gip", require('telescope.builtin').lsp_implementations, {desc= 'Go to implementations'})
map("n", "<leader>ds", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
--map("n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>", options)
map("n", "<leader>ca", vim.lsp.buf.code_action, options)
-- Fuzzy find all the symbols in your current document.
--  Symbols are things like variables, functions, types, etc.
map("n","<leader>ds", require('telescope.builtin').lsp_document_symbols, {desc="Document Symbols"})
-- Fuzzy find all the symbols in your current workspace.
--  Similar to document symbols, except searches over your entire project.
map("n",'<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {desc="Workspace Symbols"})

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, options)
map("n", "[d", vim.diagnostic.goto_prev, options)
map("n", "]d", vim.diagnostic.goto_next, options)

-- telescope
local builtin = require('telescope.builtin')
map('n', '<leader>fk', builtin.keymaps, {desc="Find Keymaps"})
map('n', '<leader>fw', builtin.grep_string, {desc="Find current Word"})
map('n', '<leader>fd', builtin.diagnostics, {desc="Find Diagnostics"})
map('n', '<leader>f.', builtin.oldfiles, {desc="Find recent files"})
map('n', '<leader>ff', builtin.find_files, {desc= 'Find files'})
map('n', '<leader>fg', builtin.live_grep, {desc='Live grep'})
map('n', '<leader>fb', builtin.buffers, {desc= 'Find buffers'})
map('n', '<leader>fh', builtin.help_tags, {desc='Find help tags'})
-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>g/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = 'Search in open files' })

-- directoty buffer for oil
local oil = require("oil")
map("n", "<leader>s", '<cmd>Oil --float .<CR>', { desc = "Open current directory buffer" })

-- harpoon 
local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup()
-- REQUIRED

map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function() harpoon:list():prev() end)
map("n", "<C-S-N>", function() harpoon:list():next() end)
