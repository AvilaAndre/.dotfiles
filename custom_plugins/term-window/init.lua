local default_config = {
    width_mul = 0.6,
    height_mul = 0.6,
    border = 'rounded',
    style = 'minimal',
    title = 'TermWindow',
}

local state = {
    window = {
        buf = -1,
        win = -1,
    },
    config = default_config,
}

local create_floating_window = function(buf)
    local buffer = buf or -1

    if not vim.api.nvim_buf_is_valid(buffer) then
        buffer = vim.api.nvim_create_buf(false, true)
    end

    local width = math.floor(vim.o.columns * state.config.width_mul)
    local height = math.floor(vim.o.lines * state.config.height_mul)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height - 3) / 2) -- TODO: check if has line on bottom

    local window_conf = {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = state.config.style,
        border = state.config.border,
        title = state.config.title,
    }

    local window = vim.api.nvim_open_win(buffer, true, window_conf)


    return { buf = buffer, win = window }
end

local toggle_window = function()
    if not vim.api.nvim_win_is_valid(state.window.win) then
        state.window = create_floating_window(state.window.buf)
        if vim.bo[state.window.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.window.win)
    end
end

local function setup(opts)
    state.config = vim.tbl_deep_extend("force", state.config, opts or {})

    vim.api.nvim_create_user_command("TermWindow", function()
        toggle_window()
    end, {})


    vim.keymap.set('n', '<leader>q', '<cmd>TermWindow<cr>')
end

return { setup = setup }
