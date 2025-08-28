return {
    "neovim/nvim-lspconfig",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "williamboman/mason.nvim",
        -- "saghen/blink.cmp",

        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        --
        -- Disable LSP logging
        --
        vim.lsp.set_log_level(vim.log.levels.OFF)

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
        -- Function to run when the LSP server attaches to a buffer.
        --
        local on_attach = function(client, bufnr)
            -- vim.notify("Attached: " .. client.name, vim.log.levels.INFO)

            local opts = { buffer = bufnr, silent = true }
            local map = function(mode, keys, fn, desc)
                opts.desc = desc
                vim.keymap.set(mode, keys, fn, opts)
            end
            local mapn = function(keys, fn, desc)
                map("n", keys, fn, desc)
            end

            -- Buffer local mappings.

            if client.server_capabilities.documentLinkProvider then
                mapn("gs", function()
                    local params = { uri = vim.uri_from_bufnr(0) }
                    vim.lsp.buf_request(
                        0,
                        "textDocument/switchSourceHeader",
                        params,
                        function(err, result)
                            if err or not result then
                                vim.notify(
                                    "No matching header/source file found",
                                    vim.log.levels.WARN
                                )
                                return
                            end
                            vim.cmd("edit " .. vim.uri_to_fname(result))
                        end
                    )
                end, "Switch Source/Header")
            end

            if client.server_capabilities.declarationProvider then
                mapn("gD", vim.lsp.buf.declaration, "Goto Declaration")
            end

            if client.server_capabilities.definitionProvider then
                mapn("gd", vim.lsp.buf.definition, "Goto Definition")
            end

            if client.server_capabilities.implementationProvider then
                mapn("gi", vim.lsp.buf.implementation, "Goto Implementation")
            end

            -- if client.server_capabilities.typeDefinitionProvider then
            --     mapn("<leader>cd", vim.lsp.buf.type_definition, "Goto Type Definition")
            -- end

            if client.server_capabilities.hoverProvider then
                mapn("K", function()
                    return vim.lsp.buf.hover(vim.tbl_deep_extend("force", {}, {
                        border = "rounded",
                        title = "Symbol Info",
                    }))
                end, "Symbol Info")
            end

            if client.server_capabilities.signatureHelpProvider then
                mapn("<leader>ck", function()
                    return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", {}, {
                        border = "rounded",
                        title = "Signature Info",
                    }))
                end, "Signature Info")
            end

            -- Instead of use Trouble/Telescope/Fzf-lua
            -- if client.server_capabilities.referencesProvider then
            --     mapn("<leader>sr", vim.lsp.buf.references, "Referencies List")
            -- end

            if client.server_capabilities.renameProvider then
                mapn("<leader>cR", vim.lsp.buf.rename, "Rename Referencies")
            end

            if client.server_capabilities.codeActionProvider then
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
            end

            -- Show diagnostics in the floating window.
            -- TODO: Investigate which server capability requires this.
            -- if client.server_capabilities.diagnosticProvider then
            mapn("<leader>cf", function()
                local float_opts = { scope = "line", border = "rounded" }
                local float_bufnr, _ = vim.diagnostic.open_float(float_opts)
                if float_bufnr == nil then
                    vim.notify("No diagnostics found")
                end
            end, "Line Diagnostics")
            -- end

            if client.server_capabilities.inlayHintProvider then
                local ToggleOption = require("scratch.core.toggleopt")
                local toggle_inlineHint = ToggleOption:new("<leader>och", function(state)
                    vim.lsp.inlay_hint.enable(state)
                end, "Inline Hint")
                toggle_inlineHint:setOpts(opts)
                toggle_inlineHint:setState(vim.lsp.inlay_hint.is_enabled({}), false)
            end

            -- Instead of use "stevearc/conform.nvim" plugin
            -- if client.server_capabilities.documentFormattingProvider then
            --     mapn("<leader>bf", function()
            --         vim.lsp.buf.format({ async = true })
            --     end, "Buffer Format")
            -- end

            -- mapn("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
            -- mapn("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

            -- mapn("<leader>wl", function()
            --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, "List Workspace Folders")
        end

        --
        -- Customize the capabilities to ensure utf-16 encoding is used.
        --
        local capabilities = require("blink.cmp").get_lsp_capabilities({
            general = {
                positionEncodings = { "utf-16" },
            },
            offsetEncoding = { "utf-16" },
        }, true)

        --
        -- Apply the above configurations to all LSP clients as they attach to buffers.
        --
        local mason_lspconfig = require("mason-lspconfig")
        for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
            vim.lsp.config(server, {
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end

        --[[
        --
        -- Second method using LspAttach autocommand.
        --
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end

                local bufnr = vim.api.nvim_win_get_buf(0)
                on_attach(client, bufnr)
            end,
        })
        --]]
    end,
}
