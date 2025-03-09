return {
    "github/copilot.vim",
    enabled = false,
    cmd = {
        "Copilot",
    },
    event = {
        "InsertEnter",
    },
    init = function()
        -- This functions intended to be used to stop/resume copilot when Typr is active
        vim.api.nvim_create_autocmd("InsertEnter", {
            pattern = "*",
            callback = function()
                -- print("Type: " .. vim.bo.filetype)
                if vim.bo.filetype == "typr" then
                    -- print(vim.inspect(args))
                    vim.notify("Copilot disabled", vim.log.levels.INFO)
                    vim.cmd("Copilot disable")
                end
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            pattern = "*",
            callback = function()
                -- print("Type: " .. vim.bo.filetype)
                if vim.bo.filetype == "typr" then
                    -- print(vim.inspect(args))
                    vim.notify("Copilot enabled", vim.log.levels.INFO)
                    vim.cmd("Copilot enable")
                end
            end,
        })
    end,
}
