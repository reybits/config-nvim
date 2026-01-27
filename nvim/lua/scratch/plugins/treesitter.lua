return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- API has changed, and not supported for lazy loading anymore.
    -- So, disable lazy loading here and commented out the event and cmd fields.
    lazy = false,
    -- event = {
    --     "BufReadPost",
    --     "BufNewFile",
    -- },
    -- cmd = {
    --     "TSUpdateSync",
    --     "TSUpdate",
    --     "TSInstall",
    -- },
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        treesitter.install({
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
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function(args)
                local buf = args.buf

                -- Enable folding
                -- vim.wo[0][0].foldmethod = "expr"
                -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

                -- Enable highlighting
                pcall(vim.treesitter.start, buf)

                --[[
                -- Disable for large files
                local max_size = 1024 * 100
                local ok, stats = pcall(vim.fs.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_size then
                    vim.treesitter.stop(buf)
                    return
                end

                local max_lines = 5000
                if vim.api.nvim_buf_line_count(buf) > max_lines then
                    vim.treesitter.stop(buf)
                end
                --]]
            end,
        })
    end,
}
