return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
        -- Add and remove cursors with control + left click.
        -- Mouse support is required for these mappings to work: `set mouse+=a`
        {
            "<c-leftmouse>",
            function()
                require("multicursor-nvim").handleMouse()
            end,
            desc = "Add/remove cursor",
        },
        {
            "<c-leftdrag>",
            function()
                require("multicursor-nvim").handleMouseDrag()
            end,
            desc = "Add/remove cursor",
        },
        {
            "<c-leftrelease>",
            function()
                require("multicursor-nvim").handleMouseRelease()
            end,
            desc = "Add/remove cursor",
        },

        -- Disable and enable cursors.
        {
            "<c-q>",
            function()
                require("multicursor-nvim").toggleCursor()
            end,
            mode = { "n", "x" },
            desc = "Toggle multicursor",
        },

        -- Bring back cursors if you accidentally clear them.
        {
            "<leader>gv",
            function()
                require("multicursor-nvim").restoreCursors()
            end,
            desc = "Restore multicursors",
        },

        -- Add a cursor for all matches of cursor word/selection in the document.
        {
            "<leader>A",
            function()
                require("multicursor-nvim").matchAllAddCursors()
            end,
            mode = { "n", "x" },
            desc = "Add cursors to all matches",
        },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        if not string.find(vim.api.nvim_get_option_value("mouse", {}), "a") then
            vim.notify(
                "Mouse support is required for <c-leftmouse> mappings to work. Enable mouse support with ':set mouse+=a'",
                vim.log.levels.WARN
            )
        end

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ "n", "x" }, "<left>", mc.prevCursor)
            layerSet({ "n", "x" }, "<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
    end,
}
