-- Neovim AI sidekick that integrates Copilot LSP's "Next Edit Suggestions"
-- with a built-in terminal for any AI CLI.
--
return {
    "folke/sidekick.nvim",
    keys = {
        {
            "<tab>",
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if not require("sidekick").nes_jump_or_apply() then
                    return "<Tab>" -- fallback to normal tab
                end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<c-.>",
            function()
                require("sidekick.cli").toggle()
            end,
            desc = "Sidekick Toggle",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>aa",
            function()
                require("sidekick.cli").toggle()
            end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function()
                require("sidekick.cli").select()
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
            end,
            desc = "Select CLI",
        },
        {
            "<leader>ad",
            function()
                require("sidekick.cli").close()
            end,
            desc = "Detach a CLI Session",
        },
        {
            "<leader>at",
            function()
                require("sidekick.cli").send({ msg = "{this}" })
            end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function()
                require("sidekick.cli").send({ msg = "{file}" })
            end,
            desc = "Send File",
        },
        {
            "<leader>av",
            function()
                require("sidekick.cli").send({ msg = "{selection}" })
            end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<leader>ap",
            function()
                require("sidekick.cli").prompt()
            end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>a", group = "AI", mode = { "n", "x" } },
        })
    end,
    opts = {
        cli = {
            mux = {
                -- backend = "tmux",
                enabled = true,
            },
            -- Does nothing, unfortunately
            -- prompts = {
            --     commit = "Write a concise git commit message for the following changes:\n\n{selection}\n\nCommit message:",
            -- },
        },
        nes = {
            diff = {
                inline = false,
            },
        },
    },
}
