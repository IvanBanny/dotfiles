return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()

        vim.lsp.config("clangd", {            
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders=1",
            },
        })

        vim.lsp.config("pyright", {
            filetypes = { "python" },
            cmd = { "pyright-langserver", "--stdio" },
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            filetypes = { "python" },
            cmd = { "ruff", "server" },
        })

        vim.lsp.enable({ "clangd", "pyright", "ruff" })

        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "pyright", "ruff" },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
                vim.keymap.set("v", "<leader>f", vim.lsp.buf.format)
            end,
        })
    end,
}

