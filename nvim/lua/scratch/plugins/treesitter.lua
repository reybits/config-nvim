return {
    "nvim-treesitter/nvim-treesitter",
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    build = ":TSUpdate",
    cmd = {
        "TSUpdateSync",
        "TSUpdate",
        "TSInstall",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            highlight = {
                enable = true,
                disable = function(_, bufnr)
                    local max_size = 1024 * 100
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                    if ok and stats and stats.size > max_size then
                        return true
                    end

                    local max_lines = 5000
                    return vim.api.nvim_buf_line_count(bufnr) > max_lines
                end,
            },
            -- Indentation based on treesitter for the = operator.
            -- This is an experimental feature.
            -- Therefore I disable it at all.
            indent = {
                enable = false,
                -- disable = { "c", "cpp" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            ignore_install = {},
            modules = {},
            auto_install = true,
            sync_install = false,
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "make",
                "css",
                "html",
                "javascript",
                "java",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "gitignore",
                "vim",
                "vimdoc",
                "yaml",
            },
        })
    end,
}
