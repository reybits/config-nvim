return {
    "github/copilot.vim",
    dependencies = {
        "fang2hou/blink-copilot",
    },
    cmd = {
        "Copilot",
    },
    --[[
    -- Disabled due error described in the issue below.
    -- https://github.com/ibhagwan/fzf-lua/issues/2247#issuecomment-3192963942
    event = {
        -- Only "BufWinEnter" is required for Copilot to work when using the blink-cmp plugin.
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        "BufWinEnter",
        -- "InsertEnter",
    },
    --]]
    init = function()
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        vim.g.copilot_no_maps = true
    end,
    config = function()
        -- Related to blink-copilot documentation: https://github.com/fang2hou/blink-copilot
        -- Block the normal Copilot suggestions
        vim.api.nvim_create_augroup("github_copilot", { clear = true })
        vim.api.nvim_create_autocmd({ "FileType", "BufUnload", "BufEnter" }, {
            group = "github_copilot",
            callback = function(args)
                vim.fn["copilot#On" .. args.event]()
            end,
        })
    end,
}
