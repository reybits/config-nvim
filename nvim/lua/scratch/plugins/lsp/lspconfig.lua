return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason should be loaded before lspconfig to ensure LSP servers are installed.
        "mason-org/mason.nvim",

        -- I assume that vim.notify handler is set before nvim-lspconfig is loaded.
        "j-hui/fidget.nvim",
    },
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        --
        -- Disable LSP logging. Neovim's RPC layer logs all LSP server stderr
        -- output (e.g., clangd info messages) as ERROR, causing the log file
        -- (~/.local/state/nvim/lsp.log) to grow unboundedly. Real LSP issues
        -- are still surfaced via vim.notify and diagnostics.
        --
        if vim.lsp.log ~= nil then
            vim.lsp.log.set_level(vim.log.levels.OFF)
        else
            -- TODO: Remove else part once Neovim 0.12+ is released.
            ---@diagnostic disable-next-line: deprecated
            vim.lsp.set_log_level(vim.log.levels.OFF)
        end

        --
        -- Set up custom diagnostic signs using icons from scratch.core.helpers.
        --
        local helpers = require("scratch.core.helpers")
        local signs = { text = {} }
        for type, icon in pairs(helpers.icons.diagnostics) do
            local key = string.upper(type)
            signs.text[vim.diagnostic.severity[key]] = icon
        end
        vim.diagnostic.config({
            signs = signs,
        })

        --
        -- Configure Lua Language Server for Neovim development
        -- Special Lua Config, as recommended by neovim help docs
        --
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (
                            vim.uv.fs_stat(path .. "/.luarc.json")
                            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                        )
                    then
                        return
                    end
                end

                client.config.settings.Lua =
                    vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                            path = { "lua/?.lua", "lua/?/init.lua" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- This is a lot slower and will cause issues when working on your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    })
            end,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        vim.lsp.config("clangd", {
            cmd = { "clangd", "--offset-encoding=utf-16" },
        })

        vim.lsp.config("copilot", {
            cmd = { "copilot-language-server", "--stdio" },
            root_markers = { ".git" },
            settings = {
                telemetry = {
                    telemetryLevel = "off",
                },
            },
        })

        --
        -- Enable specific LSP servers.
        -- LSP servers installed via mason.nvim and configured via lspconfig.
        --
        vim.lsp.enable({
            "clangd",
            "copilot",
            -- "groovyls",
            "jdtls",
            "jsonls",
            -- "kotlin_language_server",
            "lua_ls",
            "neocmake",
            "quick_lint_js",
        })

        -- TODO: Remove once Neovim 0.12+ is released.
        if vim.lsp.inline_completion == nil then
            local msg = "Inline Completion is not supported."
            vim.notify(msg, vim.log.levels.WARN)
            vim.print(msg .. " Update to Neovim 0.12+ to use this feature.")
        end

        --
        -- Function to run when the LSP server attaches to a buffer.
        --
        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc, mode)
                mode = mode or "n"
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, silent = true })
            end

            -- Because of Neovim function Client:supports_method(method, bufnr)
            -- always returns true for unknown off-spec methods, we need to
            -- check it more carefully.
            local is_supported = function(method)
                if client.server_capabilities == nil then
                    return false
                end
                return client.server_capabilities[method .. "Provider"] == true
            end

            local ToggleOption = require("scratch.core.toggleopt")

            -- Instead of "stevearc/conform.nvim" plugin
            --[[
            if client.server_capabilities.documentFormattingProvider then
                local toggle_autoformat = ToggleOption:new("<leader>oef", function(state)
                    vim.g.autoformat_toggle = state
                end, function()
                    return vim.g.autoformat_toggle ~= false
                end, "Autoformat")
                toggle_autoformat:setOpts({ buffer = bufnr, silent = true })
                toggle_autoformat:setState(toggle_autoformat:getState(), false)

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("lsp-buffer-format", { clear = false }),
                    callback = function()
                        if vim.g.autoformat_toggle ~= false then
                            vim.lsp.buf.format({ async = false })
                        end
                    end,
                })

                map("<leader>bf", function()
                    vim.lsp.buf.format({ async = false })
                end, "Buffer Format")
            end
            --]]

            -- Inline Completion. Requires nvim 0.12 and above.
            if client.name == "copilot" and vim.lsp.inline_completion ~= nil then
                -- Enable inline completion globally by default.
                vim.lsp.inline_completion.enable(true)
                -- vim.notify("Inline Completion Enabled", vim.log.levels.INFO)

                vim.keymap.set("i", "<Tab>", function()
                    if not vim.lsp.inline_completion.get() then
                        return "<Tab>"
                    end
                end, { expr = true, desc = "Accept the current inline completion" })

                vim.keymap.set("i", "<m-]>", function()
                    vim.lsp.inline_completion.select()
                end, { expr = true, desc = "Select the next inline completion" })

                vim.keymap.set("i", "<m-[>", function()
                    vim.lsp.inline_completion.select({ count = -1 })
                end, { expr = true, desc = "Select the previous inline completion" })

                vim.keymap.set("i", "<C-e>", function()
                    vim.lsp.inline_completion.get({
                        on_accept = function(_)
                            return nil
                        end,
                    })
                end, { expr = true, desc = "Dismiss the current inline completion" })

                local inline_completion = ToggleOption:new("<leader>oi", function(state)
                    vim.lsp.inline_completion.enable(state)
                end, function()
                    return vim.lsp.inline_completion.is_enabled()
                end, "Inline Completion")
                inline_completion:setOpts({ buffer = bufnr, silent = true })
                inline_completion:setState(inline_completion:getState(), false)
            end

            -- Switch Source/Header for C/C++
            if client.name == "clangd" then
                map("gs", function()
                    vim.lsp.buf_request(
                        0,
                        "textDocument/switchSourceHeader",
                        vim.lsp.util.make_text_document_params(),
                        function(err, result)
                            if err then
                                -- Sometimes lsp asks clangd twice and the second time
                                -- clangd responds with an error like:
                                -- { code = -32601, message = "unimplemented" }
                                -- So we just ignore it.
                                -- vim.notify("Error: " .. vim.inspect(err), vim.log.levels.WARN)
                                return
                            end

                            if not result or #result == 0 then
                                vim.notify(
                                    "No matching header/source file found",
                                    vim.log.levels.WARN
                                )
                                return
                            end

                            -- result can be a string or a table of strings
                            local target = type(result) == "table" and result[1] or result
                            if target then
                                vim.cmd("edit " .. vim.uri_to_fname(target))
                            else
                                vim.notify("No valid target file found", vim.log.levels.WARN)
                            end
                        end
                    )
                end, "Switch Source/Header")
            end

            if client.server_capabilities.declarationProvider then
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")
            end

            if client.server_capabilities.definitionProvider then
                map("gd", vim.lsp.buf.definition, "Goto Definition")
            end

            if client.server_capabilities.implementationProvider then
                map("gi", vim.lsp.buf.implementation, "Goto Implementation")
            end

            -- if client.server_capabilities.typeDefinitionProvider then
            --     map("<leader>cd", vim.lsp.buf.type_definition, "Goto Type Definition")
            -- end

            if client.server_capabilities.hoverProvider then
                map("K", function()
                    return vim.lsp.buf.hover(vim.tbl_deep_extend("force", {}, {
                        border = "rounded",
                        title = "Symbol Info",
                    }))
                end, "Symbol Info")
            end

            if client.server_capabilities.signatureHelpProvider then
                map("<leader>ck", function()
                    return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", {}, {
                        border = "rounded",
                        title = "Signature Info",
                    }))
                end, "Signature Info")
            end

            -- Instead of use Trouble/Telescope/Fzf-lua
            -- if client.server_capabilities.referencesProvider then
            --     map("<leader>sr", vim.lsp.buf.references, "Referencies List")
            -- end

            if client.server_capabilities.renameProvider then
                map("<leader>cR", vim.lsp.buf.rename, "Rename Referencies")
            end

            if client.server_capabilities.codeActionProvider then
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
            end

            -- Show diagnostics in the floating window.
            -- TODO: Investigate which server capability requires this.
            -- if client.server_capabilities.diagnosticProvider then
            map("<leader>cf", function()
                local float_opts = { scope = "line", border = "rounded" }
                local float_bufnr, _ = vim.diagnostic.open_float(float_opts)
                if float_bufnr == nil then
                    vim.notify("No diagnostics found")
                end
            end, "Line Diagnostics")
            -- end

            if client.server_capabilities.inlayHintProvider then
                local toggle_inlineHint = ToggleOption:new("<leader>coh", function(state)
                    vim.lsp.inlay_hint.enable(state)
                end, function()
                    return vim.lsp.inlay_hint.is_enabled({})
                end, "Inline Hint")
                toggle_inlineHint:setOpts({ buffer = bufnr, silent = true })
                toggle_inlineHint:setState(toggle_inlineHint:getState(), false)
            end

            -- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
            -- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

            -- map("<leader>wl", function()
            --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, "List Workspace Folders")
        end

        --
        -- Attach the on_attach function to LSP clients when they connect.
        --
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end

                -- vim.print(
                --     "Attach: "
                --         .. client.name
                --         .. ", with cpabilities:\n"
                --         .. vim.inspect(client.server_capabilities)
                -- )

                on_attach(client, args.buf)
            end,
        })
    end,
}
