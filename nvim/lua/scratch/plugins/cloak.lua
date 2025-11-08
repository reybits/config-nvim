local ToggleOption = require("scratch.core.toggleopt")

-- Cloak enabled by default.
local toggle_cloak = ToggleOption:new("<leader>oec", function(state)
    vim.g.cloak_enabled = state
    if state then
        vim.cmd("CloakEnable")
    else
        vim.cmd("CloakDisable")
    end
end, function()
    return vim.g.cloak_enabled ~= false
end, "Cloak")

return {
    "laytan/cloak.nvim",
    event = "BufReadPre",
    keys = {
        toggle_cloak:getMappingTable(),
    },
    cmd = {
        "CloakEnable",
        "CloakDisable",
        "CloakToggle",
    },
    opts = {
        patterns = {
            {
                -- Match any file starting with '.env'.
                -- This can be a table to match multiple file patterns.
                file_pattern = ".env*",
                -- Match an equals sign and any character after it.
                -- This can also be a table of patterns to cloak,
                -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                cloak_pattern = "=.+",
                -- A function, table or string to generate the replacement.
                -- The actual replacement will contain the 'cloak_character'
                -- where it doesn't cover the original text.
                -- If left empty the legacy behavior of keeping the first character is retained.
                replace = nil,
            },
            {
                file_pattern = "*-env*",
                cloak_pattern = "=.+",
            },
        },
    },
}
