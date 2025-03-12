local ToggleOption = require("scratch.core.toggleopt")

local toggle_illuminate = ToggleOption:new("<leader>oei", function(state)
    if state then
        vim.cmd("IlluminateResume")
    else
        vim.cmd("IlluminatePause")
    end
end, "Illuminate", true)

return {
    "RRethy/vim-illuminate",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    cmd = {
        "IlluminateDebug",
        "IlluminatePause",
        "IlluminatePauseBuf",
        "IlluminateResume",
        "IlluminateResumeBuf",
        "IlluminateToggle",
        "IlluminateToggleBuf",
    },
    keys = {
        {
            toggle_illuminate:getMapping(),
            toggle_illuminate:getToggleFunc(),
            desc = toggle_illuminate:getCurrentDescription(),
        },

        {
            "]]",
            function()
                require("illuminate").goto_next_reference(true)
            end,
            desc = "Goto Next Reference",
        },

        {
            "[[",
            function()
                require("illuminate").goto_prev_reference(true)
            end,
            desc = "Goto Prev Reference",
        },
    },
    init = function()
        -- disable illuminate on big files
        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = { "*" },
            callback = function()
                local file = vim.fn.expand("%:p")
                local ok, stats = pcall(vim.loop.fs_stat, file)

                local max_size = 1024 * 100
                if not ok or not stats or stats.size > max_size then
                    vim.cmd("IlluminatePauseBuf")
                else
                    vim.cmd("IlluminateResumeBuf")
                end
            end,
        })
    end,
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure({
            filetypes_denylist = {
                "DiffviewFiles",
                "DressingInput",
                "DressingSelect",
                "Jaq",
                "NeogitCommitMessage",
                "NvimTree",
                "Outline",
                "TelescopePrompt",
                "Trouble",
                "alpha",
                "checkhealth",
                "dirbuf",
                "dirvish",
                "fugitive",
                "fugitiveblame",
                "harpoon",
                "lazy",
                "lir",
                "mason",
                "neo-tree",
                "netrw",
                "qf",
                "spectre_panel",
                "toggleterm",
            },
            -- large_file_cutoff: number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = 2000,
        })
    end,
}
