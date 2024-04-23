return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "stevearc/dressing.nvim",
    },
    config = function()
        local mason = require("mason")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local lspconfig = require("mason-lspconfig")
        lspconfig.setup({
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
                -- "shfmt", -- (Formatter) Bash, Mksh, Shell
                -- "codelldb", -- (DAP) C, C++, Rust
                -- "cpplint", -- (Linter) C, C++
                "shellcheck", -- (Linter) BASH
                -- "luacheck", -- (Linter) Lua
            },
        })
    end,
}
