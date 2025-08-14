local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "scratch.plugins" },
    { import = "scratch.plugins.ai" },
    { import = "scratch.plugins.dap" },
    { import = "scratch.plugins.lsp" },
    { import = "scratch.plugins.ui" },
    { import = "scratch.plugins.vcs" },
    { import = "scratch.custom" },
}, {
    checker = {
        enabled = true, -- automatically check for plugin updates
        -- frequency = 86400, -- check for updates every day
        frequency = 604800, -- check for updates every week
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        border = "rounded",
        title = " Lazy Plugin Manager ",
        custom_keys = {
            ["<localleader>l"] = nil,
            ["<localleader>t"] = nil,
        },
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
