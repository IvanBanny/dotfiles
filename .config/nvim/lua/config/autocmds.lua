-- Python: enforce 88-char line limit marker
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.colorcolumn = "88"
    end,
})

-- YAML/JSON: use 2-space indentation
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yaml", "json" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})
