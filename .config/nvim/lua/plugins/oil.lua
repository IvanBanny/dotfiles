return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
                "permissions",
                "size",
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".."
                end,
            },
            use_default_keymaps = true,
        })
        
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
