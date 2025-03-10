return {
    "nvzone/typr",
    dependencies = {
        "nvzone/volt",
    },
    cmd = {
        "Typr",
        "TyprStats",
    },
    keys = {
        { "<leader>ttt", "<cmd>Typr<cr>", desc = "Open Typr" },
        { "<leader>tts", "<cmd>Typr<cr>", desc = "Typr Stats" },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>tt", group = "Typr" },
        })
    end,
    opts = {},
}
