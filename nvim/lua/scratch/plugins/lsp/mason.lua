--
-- Mason
-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
--
-- I have removed the following plugins in favor of manual installation and configuration:
-- "mason-org/mason-lspconfig.nvim",
-- "WhoIsSethDaniel/mason-tool-installer.nvim",
-- "jay-babu/mason-nvim-dap.nvim",
--
-- Mason just install the required tools.
-- DAP, LSP, and other configurations are done manually.
--
return {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    config = function()
        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        local ensure_installed = {
            -- LSP Servers
            --
            "clangd", -- (LSP) C, C++
            "jdtls", -- (LSP) Java
            "stylua", -- (LSP, Formatter) Lua, Luau
            "json-lsp", -- "jsonls", -- (LSP) Json
            "lua-language-server", -- "luals", -- "lua_ls", -- (LSP) Lua
            "neocmakelsp", -- "neocmake", -- (LSP) CMake
            "quick-lint-js", -- "quick_lint_js", -- (LSP, Linter) TypeScript, JavaScript
            "copilot-language-server", -- "copilot", -- (LSP) GitHub Copilot
            -- "groovy-language-server", -- "groovyls", -- (LSP) Groovy
            -- "kotlin-language-server", -- "kotlinls", -- (LSP) Kotlin
            -- "java_language_server", -- (LSP, DAP) Java
            -- "lemminx", -- (LSP) Xml
            -- "tsserver", -- (LSP) TypeScript, JavaScript

            -- Other tools
            --
            "clang-format", -- (Formatter) C, C#, C++, JSON, Java, JavaScript
            "codelldb", -- (DAP) C, C++, Rust
            "prettier", -- (Formatter) Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
            "shellcheck", -- (Linter) BASH
            "shfmt", -- (Formatter) Bash, Mksh, Shell
            "stylua", -- (Formatter) Lua, Luau
            -- "tree-sitter-cli", -- (Parser) Treesitter CLI
            -- "cpplint", -- (Linter) C, C++
            -- "google-java-format", --  (Formatter) Java
            -- "luacheck", -- (Linter) Lua
        }

        -- Delay the installation a bit to ensure Mason is fully loaded.
        vim.defer_fn(function()
            local mason_registry = require("mason-registry")

            -- Check is registry is ready to install packages.
            mason_registry.refresh(vim.schedule_wrap(function()
                -- Install ensured packages if they are not installed yet.
                for _, name in ipairs(ensure_installed) do
                    local ok, result = pcall(mason_registry.is_installed, name)
                    if ok and not result then
                        ok, result = pcall(mason_registry.has_package, name)
                        if ok and result then
                            vim.cmd("MasonInstall " .. name)
                        else
                            vim.notify("Mason: Package not found: " .. name, vim.log.levels.WARN)
                        end
                    end
                end
            end))
        end, 500)
    end,
}
