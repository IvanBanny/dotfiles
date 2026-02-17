-- === General ===
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
