return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = { "mason-org/mason.nvim" },
            opts = {
                ensure_installed = { "codelldb", "debugpy" },
                automatic_installation = true,
            },
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        -- codelldb adapter (>= 1.11.0 uses executable/stdio).
        dap.adapters.codelldb = {
            type = "executable",
            command = "codelldb",
        }

        -- Build current file with debug symbols, return output path.
        local build_cmd = {
            c = "gcc -g -o %s %s",
            cpp = "g++ -g -o %s %s",
            cuda = "nvcc -g -G -o %s %s",
        }

        local function build_current_file()
            local ft = vim.bo.filetype
            local fmt = build_cmd[ft]
            if not fmt then
                vim.notify("No build command for filetype: " .. ft, vim.log.levels.ERROR)
                return nil
            end
            local src = vim.fn.expand("%:p")
            local out = vim.fn.expand("%:p:r")
            local cmd = string.format(fmt, vim.fn.shellescape(out), vim.fn.shellescape(src))
            print("Building: " .. cmd)
            local result = vim.fn.system(cmd)
            if vim.v.shell_error ~= 0 then
                vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
                return nil
            end
            return out
        end

        -- Debug configurations for C, C++, and CUDA.
        local launch_config = {
            {
                name = "Build and debug current file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return build_current_file()
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
            {
                name = "Launch executable (manual path)",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input(
                        "Path to executable: ", vim.fn.getcwd() .. "/", "file"
                    )
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
        dap.configurations.c = launch_config
        dap.configurations.cpp = launch_config
        dap.configurations.cuda = launch_config

        -- debugpy adapter for Python.
        dap.adapters.debugpy = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
            args = { "-m", "debugpy.adapter" },
        }

        dap.configurations.python = {
            {
                name = "Launch file",
                type = "debugpy",
                request = "launch",
                program = "${file}",
                cwd = "${workspaceFolder}",
                pythonPath = "python3",
            },
        }

        -- Auto open/close UI on debug session start/end.
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Keymaps.
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
        vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
        vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
        vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Conditional breakpoint" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
        vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
        vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })
        vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run last" })
        vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: Evaluate expression" })
    end,
}
