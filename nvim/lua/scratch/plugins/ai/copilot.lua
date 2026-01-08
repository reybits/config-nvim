return {
    -- INFO: Suggestion mappings:
    -- <C-]> - Dismiss the current suggestion.
    -- <M-]> - Cycle to the next suggestion, if one is available.
    -- <M-[> - Cycle to the previous suggestion.
    -- <M-\> - Explicitly request a suggestion, even if Copilot <Plug>(copilot-suggest) is disabled.
    -- <M-Right> or <M-l> - Accept the next word of the current suggestion.
    -- <M-C-Right> or <M-j> - Accept the next line of the current suggestion.

    "github/copilot.vim",
    cmd = {
        "Copilot",
    },
    event = {
        -- Only "BufWinEnter" is required for Copilot to work when using the blink-cmp plugin.
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        -- "BufWinEnter",
        -- Load copilot when entering insert mode instead of BufWinEnter event.
        "InsertEnter",
    },
    -- init = function()
    --     -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
    --     vim.g.copilot_no_maps = true
    -- end,
    config = function()
        --     -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        --     -- Block the normal Copilot suggestions
        --     vim.api.nvim_create_augroup("github_copilot", { clear = true })
        --     vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
        --         group = "github_copilot",
        --         callback = function(args)
        --             vim.notify("Event: " .. args.event, vim.log.levels.INFO)
        --             vim.notify("FileType: " .. vim.bo[args.buf].filetype, vim.log.levels.INFO)
        --             vim.fn["copilot#On" .. args.event]()
        --         end,
        --     })

        -- Alias for <m-right>
        vim.keymap.set("i", "<m-l>", "copilot#AcceptWord()", {
            expr = true,
            silent = true,
            script = true,
            desc = "Copilot: Accept next word",
        })

        -- Alias for <m-c-right>
        vim.keymap.set("i", "<m-j>", "copilot#AcceptLine()", {
            expr = true,
            silent = true,
            script = true,
            desc = "Copilot: Accept next Line",
        })

        -- Attach copilot to the current buffer when entering insert mode.
        vim.fn["copilot#OnFileType"]()
    end,

    --[[
    -- INFO: Suggestion mappings:
    -- accept = "<M-l>" or <tab>
    -- next = "<M-]>"
    -- prev = "<M-[>"
    -- dismiss = "<C-]>"

    "zbirenbaum/copilot.lua",
    cmd = {
        "Copilot",
    },
    event = {
        "InsertEnter",
    },
    config = function()
        require("copilot").setup({
            suggestion = { enabled = true },
            panel = { enabled = false },
            filetypes = {
                c = true,
                cpp = true,
                gitcommit = true,
                gitrebase = true,
                help = true,
                lua = true,
                markdown = true,
                ["*"] = false,
            },
        })

        -- HACK: Ugly hack to toggle copilot off and on again to make it work with blink-cmp.
        vim.cmd("Copilot! attach")

        -- Hide copilot suggestions when blink-cmp menu is open
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                require("copilot.suggestion").dismiss()
                vim.b.copilot_suggestion_hidden = true
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.b.copilot_suggestion_hidden = false
            end,
        })
    end,
    --]]
}
