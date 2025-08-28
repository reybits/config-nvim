return {
    "nvim-mini/mini.files",
    keys = {
        {
            "<leader>ee",
            function()
                local file = require("mini.files")
                if not file.close() then
                    file.open()
                end
            end,
            desc = "Open Mini.Files (cwd)",
        },
        {
            "<leader>ef",
            function()
                local file = require("mini.files")
                if not file.close() then
                    file.open(vim.api.nvim_buf_get_name(0))
                end
            end,
            desc = "Open Mini.Files",
        },
    },
    opts = {},
}
