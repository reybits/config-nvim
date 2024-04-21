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

                opts.desc = "Goto Declaration"
                map("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Goto Definition"
                map("n", "gd", vim.lsp.buf.definition, opts)

                opts.desc = "Goto Type Definition"
                map("n", "<space>D", vim.lsp.buf.type_definition, opts)

                opts.desc = "Goto Implementation"
                map("n", "gi", vim.lsp.buf.implementation, opts)

                opts.desc = "Symbol Info"
                map("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Signature Info"
                map("n", "<c-k>", vim.lsp.buf.signature_help, opts)

                -- opts.desc = "Show Referencies"
                -- map("n", "gr", vim.lsp.buf.references, opts)

                opts.desc = "Rename All Referencies"
                map("n", "<space>R", vim.lsp.buf.rename, opts)

                opts.desc = "Show Code Action"
                map({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

                -- map("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end, opts)

                -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                -- map("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
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
