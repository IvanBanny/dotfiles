vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")

if vim.g.vscode then
    -- vscode setup
    local vscode = require("vscode-neovim")
else
    -- native nvim setup
    require("config.rsync")
    require("config.lazy")
end
