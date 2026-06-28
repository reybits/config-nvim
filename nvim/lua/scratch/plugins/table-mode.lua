local ToggleOption = require("scratch.core.toggleopt")

ToggleOption.new({
    map = "<leader>oet",
    title = "Table Mode",
    get = function()
        return vim.b.table_mode_active ~= nil and vim.b.table_mode_active ~= 0
    end,
    set = function(state)
        if state then
            vim.cmd("TableModeEnable")
        else
            vim.cmd("TableModeDisable")
        end
    end,
})

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
    init = function()
        vim.g.table_mode_verbose = 0
    end,
}
