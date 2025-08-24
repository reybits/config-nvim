return {
    --[[
    -- Plugin disabled due error described in the issue below.
    -- https://github.com/ibhagwan/fzf-lua/issues/2247#issuecomment-3192963942
    -- Use 'zbirenbaum/copilot.lua' instead.
    "github/copilot.vim",
    cmd = {
        "Copilot",
    },
    event = {
        -- Only "BufWinEnter" is required for Copilot to work when using the blink-cmp plugin.
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        -- "BufWinEnter",
        "InsertEnter", -- load copilot when entering insert mode instead of BufWinEnter event
    },
    init = function()
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        vim.g.copilot_no_maps = true
    end,
    config = function()
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        -- Block the normal Copilot suggestions
        vim.api.nvim_create_augroup("github_copilot", { clear = true })
        vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
            group = "github_copilot",
            callback = function(args)
                vim.fn["copilot#On" .. args.event]()
            end,
        })
        vim.fn["copilot#OnFileType"]()
    end,
    --]]

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
}
