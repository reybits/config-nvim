return {
    "neovim/nvim-lspconfig",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        -- "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        -- "saghen/blink.cmp",

        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- local lspconfig = require("lspconfig")

        local helpers = require("scratch.core.helpers")
        for type, icon in pairs(helpers.icons.diagnostics) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local mason_lspconfig = require("mason-lspconfig")
        for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
            vim.lsp.config(server, {
                on_attach = function(client, bufnr)
                    -- print("Attached: " .. client.name)

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = bufnr, silent = true }
                    local map = function(mode, keys, fn, desc)
                        opts.desc = desc
                        vim.keymap.set(mode, keys, fn, opts)
                    end
                    local mapn = function(keys, fn, desc)
                        map("n", keys, fn, desc)
                    end

                    for _, client in ipairs(vim.lsp.get_clients()) do
                        if client.name == "clangd" then
                            mapn("gs", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source/Header")
                        end
                    end

                    if client ~= nil then
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
                            local function hover()
                                return vim.lsp.buf.hover(vim.tbl_deep_extend("force", {}, {
                                    border = "rounded",
                                    title = "Symbol Info",
                                }))
                            end
                            mapn("K", hover, "Symbol Info")
                        end

                        if client.server_capabilities.signatureHelpProvider then
                            local function signature_help()
                                return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", {}, {
                                    border = "rounded",
                                    title = "Signature Info",
                                }))
                            end
                            mapn("<leader>ck", signature_help, "Signature Info")
                        end

                        -- Instead of use Trouble/Telescope
                        -- mapn("<leader>sr", vim.lsp.buf.references, "Referencies List")

                        if client.server_capabilities.renameProvider then
                            mapn("<leader>cR", vim.lsp.buf.rename, "Rename Referencies")
                        end

                        if client.server_capabilities.codeActionProvider then
                        -- stylua: ignore
                        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Show Code Action")
                        end

                        local ToggleOption = require("scratch.core.toggleopt")

                        if client.server_capabilities.inlayHintProvider then
                            local toggle_inlineHint = ToggleOption:new(
                                "<leader>och",
                                function(state)
                                    vim.lsp.inlay_hint.enable(state)
                                end,
                                "Inline Hint"
                            )
                            toggle_inlineHint:setOpts(opts)
                            toggle_inlineHint:setState(vim.lsp.inlay_hint.is_enabled({}), false)
                        end

                        -- mapn("<leader>bf", function()
                        --    vim.lsp.buf.format({ async = true })
                        -- end, "Buffer Format")

                        -- mapn("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
                        -- mapn("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

                        -- mapn("<leader>wl", function()
                        --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        -- end, "List Workspace Folders")
                    end
                end,
            })
        end
    end,
}
