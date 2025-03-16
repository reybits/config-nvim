return {
    -- Alternative version of codeium with blink.cmp support
    "monkoose/neocodeium",
    event = {
        "InsertEnter",
    },
    dependencies = {
        "saghen/blink.cmp",
    },
    config = function()
        local neocodeium = require("neocodeium")

        vim.api.nvim_create_augroup("neocodeium", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "neocodeium",
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                neocodeium.clear()
            end,
        })

        local blink = require("blink.cmp")
        neocodeium.setup({
            filter = function()
                return not blink.is_visible()
            end,
        })

        -- Complete Codeium suggestion by pressing <tab>
        vim.keymap.set("i", "<tab>", neocodeium.accept)

        -- Cycle Codeium suggestions by pressing <A-e>
        vim.keymap.set("i", "<A-e>", neocodeium.cycle)
    end,
}
