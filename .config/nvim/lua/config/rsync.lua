vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        local file = vim.fn.findfile(".rsync-target", ".;")
        if file == "" then return end
        local project_root = vim.fn.fnamemodify(file, ":p:h")
        local target = vim.fn.readfile(file)[1]
        vim.fn.jobstart(
            ("rsync -az --filter=':- .rsync-ignore' "
                .. "--exclude='.rsync-target' --exclude='.rsync-ignore' "
                .. "--exclude='.git' --exclude='.gitignore' "
                .. "%s/ %s"):format(project_root, target),
            { detach = true }
        )
    end,
})

