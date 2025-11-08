local ToggleOption = require("scratch.core.toggleopt")

local toggle_table = ToggleOption:new("<leader>oet", function(state)
    if state then
        vim.cmd("TableModeEnable")
    else
        vim.cmd("TableModeDisable")
    end
end, function()
    return vim.b.table_mode_active ~= nil and vim.b.table_mode_active ~= 0
end, "Table Mode")

return {
    "dhruvasagar/vim-table-mode",
    cmd = {
        "TableAddFormula",
        "TableEvalFormulaLine",
        "TableModeDisable",
        "TableModeEnable",
        "TableModeRealign",
        "TableModeToggle",
        "TableSort",
        "Tableize",
    },
    keys = {
        toggle_table:getMappingTable(),
    },
    init = function()
        vim.g.table_mode_verbose = 0
    end,
}
