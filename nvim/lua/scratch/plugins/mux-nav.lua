-- Enable seamless navigation between Neovim splits
-- and multiplexer panes (such as TMUX and WezTerm).
--
-- smart-splits.nvim v3 moved multiplexer support out of the core plugin into
-- per-backend dependencies. For tmux we pull in `backend-tmux`, which also
-- ships the matching tmux-side plugin (loaded by TPM from tmux.conf).
-- https://github.com/smart-splits-nvim/smart-splits.nvim
-- https://github.com/smart-splits-nvim/backend-tmux

return {
    "smart-splits-nvim/smart-splits.nvim",
    dependencies = {
        { "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
    },
    -- stylua: ignore
    init = function()
        vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Goto Left Window" })
        vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Goto Down Window" })
        vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Goto Up Window" })
        vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right , { desc = "Goto Right Window" })
    end,
    opts = {
        mux = {
            backend = "smart-splits-backend-tmux",
        },
        move = {
            at_edge = "stop",
        },
        log = {
            -- default logging level, one of: 'trace'|'debug'|'info'|'warn'|'error'|'fatal'
            level = "error",
            -- `true` for the default path, a string for a custom one, `false` to disable
            file = false,
        },
    },
}
