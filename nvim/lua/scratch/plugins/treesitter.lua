return {
    "reybits/ts-forge.nvim",
    config = function()
        require("ts-forge").setup({
            auto_install = true,
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
