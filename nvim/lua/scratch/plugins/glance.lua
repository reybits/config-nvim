return {
    "dnlhc/glance.nvim",
    cmd = {
        "Glance",
    },
    keys = {
        { "gD", "<cmd>Glance definitions<cr>", desc = "Preview Definitions" },
        { "gR", "<cmd>Glance references<cr>", desc = "Preview References" },
        { "gY", "<cmd>Glance type_definitions<cr>", desc = "Preview Type Definitions" },
        { "gM", "<cmd>Glance implementations<cr>", desc = "Preview Implementations" },
    },
    opts = {
        border = {
            enable = true,
        },
    },
}
