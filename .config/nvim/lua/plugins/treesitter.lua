return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Asynchronous installation of parsers
        require("nvim-treesitter").install({
            "c",
            "cpp",
            "python",
            "lua",
            "vim",
            "vimdoc",
            "query"
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                -- pcall prevents buffer crashes if a specific parser is missing
                if pcall(vim.treesitter.start) then
                    vim.bo.indentexpr = "v:lua.require(\"nvim-treesitter\").indentexpr()"
                end
            end,
        })
    end,
}
