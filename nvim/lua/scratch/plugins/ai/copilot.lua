-- Copilot plugin "github/copilot.vim" is an official plugin from GitHub for integrating GitHub Copilot into Vim/Neovim.
-- But it vim-plugin and not a lua-plugin, so it has some issues with modern Neovim setups.
-- Therefore, we use "zbirenbaum/copilot.lua" plugin which is a lua-based implementation for better integration.
--

return {
    -- Key mappings for copilot suggestions:
    -- <tab> - Show/accept the current suggestion.
    -- <m-]> - Cycle to the next suggestion, if one is available.
    -- <m-[> - Cycle to the previous suggestion.
    -- <m-l> - Accept the next word of the current suggestion.
    -- <m-j> - Accept the next line of the current suggestion.
    -- <c-e> - Dismiss the current suggestion and disable further suggestions until next navigation.

    "zbirenbaum/copilot.lua",
    cmd = {
        "Copilot",
    },
    event = {
        "InsertEnter",
    },
    config = function()
        require("copilot").setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                trigger_on_accept = false,
                keymap = {
                    -- NOTE: If <tab> is set as accept, forward the <tab> key
                    -- isn't working properly in insert mode. Looks like a bug.
                    -- So disable accept mapping here and handle it manually
                    -- in the keymaps below.
                    accept = false, -- <tab>,
                    -- NOTE: Also disable dismiss, next, and prev mappings here
                    -- and handle them manually in the keymaps below.
                    dismiss = false, -- "<c-e>",
                    next = false, -- "<m-]>",
                    prev = false, -- "<m-[>",

                    accept_word = "<m-l>",
                    accept_line = "<m-j>",
                },
            },
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

        -- NOTE: Workaround for the <tab> accept issue described above.
        -- Super Tab: Accept copilot suggestion with <Tab>, else insert a tab character.
        vim.keymap.set("i", "<tab>", function()
            if require("copilot.suggestion").is_visible() then
                require("copilot.suggestion").accept()
            else
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes("<tab>", true, false, true),
                    "n",
                    false
                )
            end
        end, { desc = "Copilot: Accept Suggestion" })

        -- NOTE: Dismiss copilot suggestion with <C-e> and disable further
        -- suggestions until next navigation.
        vim.keymap.set("i", "<c-e>", function()
            if require("copilot.suggestion").is_visible() then
                require("copilot.suggestion").dismiss()
                vim.b.copilot_suggestion_hidden = true
            end
        end, { desc = "Copilot: Dismiss Suggestion" })

        -- NOTE: Reenable copilot suggestion when cycling to previous suggestion.
        vim.keymap.set("i", "<m-]>", function()
            require("copilot.suggestion").next()
            vim.b.copilot_suggestion_hidden = false
        end, { desc = "Copilot: Next Suggestion" })
        vim.keymap.set("i", "<m-[>", function()
            require("copilot.suggestion").prev()
            vim.b.copilot_suggestion_hidden = false
        end, { desc = "Copilot: Previous Suggestion" })

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
