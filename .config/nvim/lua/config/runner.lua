-- Run the current file in a toggleable bottom terminal split.
-- <leader>x: save and (re)run, killing any previous run.
-- <leader>o: toggle the output window (keeps last output).

local M = {}

local state = { buf = -1, win = -1 }

local commands = {
    python = function(file)
        return { "uv", "run", "python", file }
    end,
}

local function win_valid()
    return vim.api.nvim_win_is_valid(state.win)
end

local function buf_valid()
    return vim.api.nvim_buf_is_valid(state.buf)
end

local function open_window()
    if win_valid() then return end
    local prev = vim.api.nvim_get_current_win()
    vim.cmd("botright 12split")
    state.win = vim.api.nvim_get_current_win()
    vim.wo[state.win].winfixheight = true
    vim.wo[state.win].number = false
    vim.wo[state.win].relativenumber = false
    vim.wo[state.win].signcolumn = "no"
    if buf_valid() then
        vim.api.nvim_win_set_buf(state.win, state.buf)
    end
    vim.api.nvim_set_current_win(prev)
end

function M.toggle()
    if win_valid() then
        vim.api.nvim_win_close(state.win, true)
    else
        open_window()
    end
end

function M.run()
    local make_cmd = commands[vim.bo.filetype]
    if not make_cmd then
        vim.notify("runner: no command for filetype '" .. vim.bo.filetype .. "'",
            vim.log.levels.WARN)
        return
    end
    local file = vim.api.nvim_buf_get_name(0)
    vim.cmd("silent! update")
    open_window()
    local old_buf = buf_valid() and state.buf or nil
    state.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(state.win, state.buf)
    if old_buf then
        -- killing the old terminal buffer also kills its job
        vim.api.nvim_buf_delete(old_buf, { force = true })
    end
    vim.keymap.set("n", "q", M.toggle, { buffer = state.buf })
    vim.api.nvim_win_call(state.win, function()
        vim.fn.jobstart(make_cmd(file), {
            term = true,
            cwd = vim.fs.dirname(file),
        })
        -- cursor on last line so the terminal follows output
        vim.cmd("normal! G")
    end)
end

vim.keymap.set("n", "<leader>x", M.run)
vim.keymap.set("n", "<leader>o", M.toggle)

return M
