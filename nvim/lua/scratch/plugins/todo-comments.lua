--------------------------------------------------------------------------------
-- Plugin to highlight and search for todo comments:
-- TODO: todo text
-- FIXME: fixme text
-- FIXIT: fixit text
-- BUG: bug text
-- HACK: hack text
-- WARN: some warnig
-- XXX: some exclamation
-- WARNING: some warnig
-- PERF: performance info
-- OPTIM: optimization info
-- PERFORMANCE: performance info
-- OPTIMIZE: optimize info
-- NOTE: note text
-- INFO: some info
-- TEST: test text
-- TESTING: testing info
-- PASSED: passed info
-- FAILED: falied info
--------------------------------------------------------------------------------

return {
    "folke/todo-comments.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = {
        -- "TodoFzfLua",
        "TodoTelescope",
        "TodoLocList",
        "TodoQuickFix",
    },
    -- stylua: ignore
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
        { "<leader>st", "<cmd>TodoQuickFix<cr>", desc = "TODOs" },
    },
    opts = {},
}
