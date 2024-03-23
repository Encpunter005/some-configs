
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window split
keymap("n", "sv", ":vsplit<CR>", opts)
keymap("n", "sh", ":split<CR>", opts)

-- Save files
keymap("n", "<C-s>", ":w<CR>", opts)

-- accelerate j k
vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})

-- float terminal
keymap("n", "<C-\\>", ":ToggleTerm size=95 direction=vertical<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<A-l>", "<gv", opts)
keymap("v", "<A-h>", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better Buffer navigation

keymap('n', "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
keymap('n', "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
keymap('n', "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
keymap('n', "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
keymap('n', "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
keymap('n', "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
keymap('n', "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
keymap('n', "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
keymap('n', "<A-9>", "<cmd>BufferGoto 9<CR>", opts)
keymap('n', "<A-0>", "<cmd>BufferGoto 0<CR>", opts)
keymap('n', "<C-w>", "<cmd>BufferClose<CR>", opts)
keymap('n', "<A-,>", "<cmd>BufferPrevious<CR>", opts)
keymap('n', "<A-.>", "<cmd>BufferNext<CR>", opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Set wrap
keymap("n", "<A-w>", "&wrap == 1 ? ':set nowrap<CR>' : ':set wrap<CR>'", { noremap = true, expr = true })
-- Operations of Debugging
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
-- use register
keymap("v" , "y","\"+y" , {noremap = true})
