-- Enable seamless navigation between Neovim splits
-- and multiplexer panes (such as TMUX and WezTerm).
-- TMUX support:
-- https://github.com/mrjones2014/smart-splits.nvim#tmux
-- WezTerm support:
-- https://github.com/mrjones2014/smart-splits.nvim#wezterm

return {
    "mrjones2014/smart-splits.nvim",
    -- stylua: ignore
    init = function()
        vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Goto Left Window" })
        vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Goto Down Window" })
        vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Goto Up Window" })
        vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right , { desc = "Goto Right Window" })
        vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous, { desc = "Previous Window" })
    end,
    opts = {
        float_win_behavior = "mux",
        at_edge = "stop",
    },
}
