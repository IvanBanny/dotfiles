local map = vim.keymap.set

-- File operations
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<Esc>", ":nohlsearch<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Visual mode very better
map("v", "<", "<gv")
map("v", ">", ">gv")

map("x", "<leader>p", "\"_dp")

-- Better movement & scrolling
map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Questionably better editing
map("n", "J", "mzJ'z")
map("n", "Y", "yg$")

-- Clipboard & register control
map({"n", "v"}, "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

map("n", "<leader>d", "\"_d")

-- Disable macro recording.
map('n', 'q', "<Nop>")

