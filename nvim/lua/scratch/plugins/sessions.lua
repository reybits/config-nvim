local ToggleOption = require("scratch.core.toggleopt")

local toggle_session = ToggleOption:new("<leader>os", function(state)
    vim.g.minisessions_disable = not state
end, "Session Save", true)

return {
    "nvim-mini/mini.sessions",
    version = false,
    cmd = {
        "SessionsList",
        "SessionRead",
        "SessionReadLast",
        "SessionWrite",
    },
    keys = {
        {
            toggle_session:getMapping(),
            toggle_session:getToggleFunc(),
            desc = toggle_session:getCurrentDescription(),
        },
    },
    config = function()
        local session = require("mini.sessions")
        session.setup({
            autoread = false,
            autowrite = true,
            -- file = "Session.vim",
            directory = vim.fn.stdpath("state") .. "/sessions/",
        })

        vim.g.minisessions_disable = false
        -- stylua: ignore
        vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

        -- force setup vim.ui.select handler
        vim.cmd("UiHandleSelect")

        vim.api.nvim_create_user_command("SessionsList", function()
            session.select()
        end, {
            desc = "Sessions List",
        })

        vim.api.nvim_create_user_command("SessionRead", function(args)
            session.read(args.args)
        end, {
            desc = "Read Session",
        })

        vim.api.nvim_create_user_command("SessionReadLast", function()
            local last_name = session.get_latest()
            session.read(last_name)
        end, {
            desc = "Read Last Session",
        })

        vim.api.nvim_create_user_command("SessionWrite", function()
            session.write()
        end, {
            desc = "Write Session",
        })
    end,
}
