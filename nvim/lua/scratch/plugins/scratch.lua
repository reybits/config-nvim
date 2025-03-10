return {
    "athar-qadri/scratchpad.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = {
        "Scratch",
    },
    keys = {
        {
            "<Leader>tss",
            function()
                local scratchpad = require("scratchpad")
                scratchpad.ui:new_scratchpad()
            end,
            desc = "Open Scratchpad",
        },
        {
            "<leader>tsp",
            function()
                local scratchpad = require("scratchpad")
                scratchpad.ui:sync()
            end,
            desc = "Push Line to Scratchpad",
        },
        {
            "<leader>tsp",
            function()
                local scratchpad = require("scratchpad")
                scratchpad.ui:sync()
            end,
            desc = "Push Selection to Scratchpad",
            mode = { "v" },
        },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            mode = { "n", "v" },
            { "<leader>ts", group = "Scratch" },
        })
    end,
    config = function()
        local scratchpad = require("scratchpad")
        scratchpad:setup({
            settings = {
                title = " Scratch Pad ",
                sync_on_ui_close = true,
            },
        })
    end,

    --[[
    "swaits/scratch.nvim",
    lazy = true,
    keys = {
        { "<leader>ts", "<cmd>Scratch<cr>", desc = "Scratch Buffer" },
        { "<leader>tS", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)" },
    },
    cmd = {
        "Scratch",
        "ScratchSplit",
    },
    opts = {},
    --]]

    --[[
    "konfekt/vim-scratchpad",
    keys = {
        { "<leader>ts", "<Plug>(ToggleScratchPad)", desc = "Toggle Scratchpad" },
    },
    config = function() end,
    --]]
}
