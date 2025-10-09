return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    cmd = {
        "Mason",
        "MasonUpdate",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
    },
    config = function()
        local mason = require("mason")
        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            automatic_installation = true,
            ensure_installed = {
                "clangd", -- (LSP) C, C++
                -- "java_language_server", -- (LSP, DAP) Java
                "jdtls", -- (LSP) Java
                "jsonls", -- (LSP) Json
                "lua_ls", -- (LSP) Lua
                "neocmake", -- (LSP) CMake
                -- "tsserver", -- (LSP) TypeScript, JavaScript
                "quick_lint_js", -- (LSP, Linter) TypeScript, JavaScript
                -- "lemminx", -- (LSP) Xml
            },
        })

        local mason_toolinst = require("mason-tool-installer")
        mason_toolinst.setup({
            automatic_installation = true,
            ensure_installed = {
                "clang-format", -- (Formatter) C, C#, C++, JSON, Java, JavaScript
                "stylua", -- (Formatter) Lua, Luau
                -- "google-java-format", --  (Formatter) Java
                "prettier", -- (Formatter) Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
                "shfmt", -- (Formatter) Bash, Mksh, Shell
                -- "codelldb", -- (DAP) C, C++, Rust
                -- "cpplint", -- (Linter) C, C++
                "shellcheck", -- (Linter) BASH
                -- "luacheck", -- (Linter) Lua
            },
        })

        -- local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
        local mason_dap = require("mason-nvim-dap")
        mason_dap.setup({
            automatic_installation = true,
            ensure_installed = {
                "codelldb",
            },
            handlers = {
                function(config)
                    -- all sources with no handler get passed here

                    -- Keep original functionality
                    mason_dap.default_setup(config)
                end,
                codelldb = function(config)
                    mason_dap.default_setup(config) -- don't forget this!
                end,
            },
        })
    end,
}
