return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
        -- { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local map = vim.keymap.set
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "[LSP] Switch Source/Header"
                map("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", opts)

                opts.desc = "[LSP] Goto Declaration"
                map("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "[LSP] Goto Definition"
                map("n", "gd", vim.lsp.buf.definition, opts)

                opts.desc = "[LSP] Goto Implementation"
                map("n", "gi", vim.lsp.buf.implementation, opts)

                opts.desc = "[LSP] Goto Type Definition"
                map("n", "<leader>cd", vim.lsp.buf.type_definition, opts)

                opts.desc = "[LSP] Symbol Info"
                map("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "[LSP] Signature Info"
                map("n", "<leader>ck", vim.lsp.buf.signature_help, opts)

                -- instead of use Trouble
                -- opts.desc = "[LSP] Referencies List"
                -- map("n", "<leader>sr", vim.lsp.buf.references, opts)

                opts.desc = "[LSP] Rename Referencies"
                map("n", "<leader>cR", vim.lsp.buf.rename, opts)

                opts.desc = "[LSP] Show Code Action"
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                -- opts.desc = "[LSP] Buffer Format"
                -- map("n", "<leader>bf", function() vim.lsp.buf.format({ async = true }) end, opts)

                -- opts.desc = "[LSP] Add Workspace Folder"
                -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)

                -- opts.desc = "[LSP] Remove Workspace Folder"
                -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)

                -- opts.desc = "[LSP] List Workspace Folders"
                -- map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
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
