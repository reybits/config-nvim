--- disable illuminate on big files --------------------------------------------
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        local file = vim.fn.expand("%:p")
        local ok, stats = pcall(vim.loop.fs_stat, file)

        local max_size = 1024 * 100
        if ok and stats and stats.size > max_size then
            vim.cmd("IlluminatePauseBuf")
        end
    end,
})

return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "IlluminatePauseBuf" },
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

        local map = vim.keymap.set
        map("n", "<leader>oi", function()
            illuminate.toggle()
            -- stylua: ignore
            print("Illiminate " .. (illuminate.is_paused() and "disabled" or "enabled"))
        end, { desc = "Toggle Illuminate" })

        map("n", "]]", function()
            illuminate.goto_next_reference(true)
        end, { desc = "Goto Next Reference" })

        map("n", "[[", function()
            illuminate.goto_prev_reference(true)
        end, { desc = "Goto Prev Reference" })
    end,
}
