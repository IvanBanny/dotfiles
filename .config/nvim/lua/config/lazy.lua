-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- === General Settings ===
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.backspace = "indent,eol,start"
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- === Display ===
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "88"
vim.opt.termguicolors = true

-- === Indentation ===
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- === Search ===
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- === Completion ===
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menuone,noselect"

-- === Performance ===
vim.opt.lazyredraw = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

-- === Splits ===
vim.opt.splitbelow = true
vim.opt.splitright = true

-- === Key Mappings ===
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local map = vim.keymap.set
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>h", ":nohlsearch<CR>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "j", "gj")
map("n", "k", "gk")

-- === Filetype Overrides ===
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.opt_local.colorcolumn = "88" end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- === Plugins ===
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = {  },
    checker = { enabled = true },
})
vim.cmd.colorscheme("anderson")

