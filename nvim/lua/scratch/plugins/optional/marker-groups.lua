return {
    "jameswolensky/marker-groups.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required
        -- "ibhagwan/fzf-lua", -- Optional: fzf-lua picker
        -- "folke/snacks.nvim", -- Optional: Snacks picker
        "nvim-telescope/telescope.nvim", -- Optional: Telescope picker
    },
    keys = {
        { "<leader>ma", nil, mode = { "n", "v" }, desc = "Add marker" },
        { "<leader>me", nil, desc = "Edit marker at cursor" },
        { "<leader>md", nil, desc = "Delete marker at cursor" },
        { "<leader>ml", nil, desc = "List markers in buffer" },
        { "<leader>mi", nil, desc = "Show marker at cursor" },

        { "<leader>mgc", nil, desc = "Create marker group" },
        { "<leader>mgs", nil, desc = "Select marker group" },
        { "<leader>mgl", nil, desc = "List marker groups" },
        { "<leader>mgr", nil, desc = "Rename marker group" },
        { "<leader>mgd", nil, desc = "Delete marker group" },
        { "<leader>mgi", nil, desc = "Show active group info" },
        { "<leader>mgb", nil, desc = "Create group from git branch" },

        { "<leader>mv", nil, desc = "Toggle drawer marker viewer" },
    },
    cmd = {
        -- Group Management:
        "MarkerGroupsCreate",
        "MarkerGroupsList",
        "MarkerGroupsSelect",
        "MarkerGroupsRename",
        "MarkerGroupsDelete",
        -- Marker Operations:
        "MarkerAdd",
        "MarkerRemove",
        "MarkerList",
        -- Viewing & Navigation:
        "MarkerGroupsView",
        "MarkerGroupsPickerStatus",
        "MarkerGroupsHealth",
        "MarkerGroupsInfo",
        -- Drawer Controls:
        "MarkerGroupsCloseDrawer",
        "MarkerGroupsDrawerWidth",
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>m", group = "Marker Groups", icon = "󰍕" },
            { "<leader>mg", group = "Group" },
        })
    end,
    config = function()
        require("marker-groups").setup({
            -- Default picker is 'vim' (built-in vim.ui)
            -- Accepted values: 'vim' | 'snacks' | 'fzf-lua' | 'mini.pick' | 'telescope'
            picker = "fzf-lua",
        })
    end,
}
