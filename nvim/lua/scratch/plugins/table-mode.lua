local ToggleOption = require("scratch.core.toggleopt")

local toggle_table = ToggleOption:new("<leader>ot", function(state)
    if state then
        vim.cmd("TableModeEnable")
    else
        vim.cmd("TableModeDisable")
    end
end, "Table Mode", false)

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
        {
            toggle_table:getMapping(),
            toggle_table:getToggleFunc(),
            desc = toggle_table:getCurrentDescription(),
        },
    },
    init = function()
        vim.g.table_mode_verbose = 0
    end,
}
