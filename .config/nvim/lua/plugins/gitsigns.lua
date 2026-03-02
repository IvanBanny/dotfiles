return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 300,
                virt_text_pos = "eol",
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = vim.keymap.set

                -- Navigation
                map("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next git hunk" })
                map("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Prev git hunk" })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
                map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Stage hunk" })
                map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Reset hunk" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
                map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
            end,
        })
    end,
}
