vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")

if vim.g.vscode then
    require("config.vscode_keymaps")
else
    -- native nvim setup
    require("config.rsync")
    require("config.lazy")
end
