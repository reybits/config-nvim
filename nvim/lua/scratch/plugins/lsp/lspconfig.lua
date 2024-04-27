return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
                title = "Symbol Info",
            })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
                title = "Signature Info",
            })

        vim.api.nvim_create_autocmd("LspAttach", {
            -- stylua: ignore
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local map = vim.keymap.set
                local opts = { buffer = args.buf, silent = true }

                opts.desc = "Switch Source/Header"
                map("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", opts)

                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client ~= nil then
                    if client.server_capabilities.declarationProvider then
                        opts.desc = "Goto Declaration"
                        map("n", "gD", vim.lsp.buf.declaration, opts)
                    end

                    if client.server_capabilities.definitionProvider then
                        opts.desc = "Goto Definition"
                        map("n", "gd", vim.lsp.buf.definition, opts)
                    end

                    if client.server_capabilities.implementationProvider then
                        opts.desc = "Goto Implementation"
                        map("n", "gi", vim.lsp.buf.implementation, opts)
                    end

                    if client.server_capabilities.typeDefinitionProvider then
                        opts.desc = "Goto Type Definition"
                        -- stylua: ignore
                        map("n", "<leader>cd", vim.lsp.buf.type_definition, opts)
                    end

                    if client.server_capabilities.hoverProvider then
                        opts.desc = "Symbol Info"
                        map("n", "K", vim.lsp.buf.hover, opts)
                    end

                    if client.server_capabilities.signatureHelpProvider then
                        opts.desc = "Signature Info"
                        map("n", "<leader>ck", vim.lsp.buf.signature_help, opts)
                    end

                    -- instead of use Trouble
                    -- opts.desc = "Referencies List"
                    -- map("n", "<leader>sr", vim.lsp.buf.references, opts)

                    if client.server_capabilities.renameProvider then
                        opts.desc = "Rename Referencies"
                        map("n", "<leader>cR", vim.lsp.buf.rename, opts)
                    end

                    if client.server_capabilities.codeActionProvider then
                        opts.desc = "Show Code Action"
                        -- stylua: ignore
                        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    end

                    -- opts.desc = "Buffer Format"
                    -- map("n", "<leader>bf", function() vim.lsp.buf.format({ async = true }) end, opts)

                    -- opts.desc = "Add Workspace Folder"
                    -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

                    -- opts.desc = "Remove Workspace Folder"
                    -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

                    -- opts.desc = "List Workspace Folders"
                    -- map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                end
            end,
        })

        local helpers = require("scratch.core.helpers")
        for type, icon in pairs(helpers.icons.diagnostics) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.offsetEncoding = { "utf-16" }

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            ["lua_ls"] = function()
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                })
            end,
        })
    end,
}
