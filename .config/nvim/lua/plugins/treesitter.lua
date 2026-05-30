-- nvim-treesitter "main" branch (the rewrite).
-- Requires Neovim >= 0.11 and the tree-sitter CLI (>= 0.25) for compiling parsers.
-- API differs from the legacy "master" branch: no configs.setup(), no auto_install.
-- We install a base set, enable highlight/indent per-buffer via FileType, and
-- lazily install any other parser on demand.
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup()

        -- Some parsers are named differently from the Neovim filetype. Register
        -- those up front so highlighting resolves before the parser installs.
        vim.treesitter.language.register("latex", { "tex", "plaintex" })

        -- Parsers to always keep installed
        local ensure = { "c", "cpp", "python", "lua", "vim", "vimdoc", "query", "latex" }

        local function installed()
            return ts.get_installed()
        end

        -- Install any missing parsers from the base set (async)
        do
            local have = installed()
            local missing = vim.tbl_filter(function(lang)
                return not vim.tbl_contains(have, lang)
            end, ensure)
            if #missing > 0 then
                ts.install(missing)
            end
        end

        local available = ts.get_available()

        -- Start highlighting/indent for a buffer once its parser is installed
        local function enable(buf, lang)
            if not vim.api.nvim_buf_is_valid(buf) then
                return
            end
            pcall(vim.treesitter.start, buf, lang)
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Enable treesitter (auto-installing the parser if needed)",
            callback = function(args)
                local buf = args.buf
                local ft = vim.bo[buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if lang == "" or not vim.tbl_contains(available, lang) then
                    return
                end

                if vim.tbl_contains(installed(), lang) then
                    enable(buf, lang)
                    return
                end

                -- Not installed yet: kick off install, then poll until ready.
                ts.install({ lang })
                local timer = assert(vim.uv.new_timer())
                local tries = 0
                timer:start(300, 300, vim.schedule_wrap(function()
                    tries = tries + 1
                    if vim.tbl_contains(installed(), lang) then
                        timer:stop()
                        timer:close()
                        enable(buf, lang)
                    elseif tries > 40 then -- give up after ~12s
                        timer:stop()
                        timer:close()
                    end
                end))
            end,
        })
    end,
}
