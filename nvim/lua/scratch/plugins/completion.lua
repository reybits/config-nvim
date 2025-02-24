return {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "vurentjie/cmp-gl",

        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",

        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        local do_next = function(fallback)
            if cmp.visible() then
                -- local entries = cmp.get_entries()
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })

                -- if #entries == 1 then
                --     cmp.confirm()
                -- end
            else
                fallback()
            end
        end
        local do_prev = function(fallback)
            if cmp.visible() then
                -- local entries = cmp.get_entries()
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })

                -- if #entries == 1 then
                --     cmp.confirm()
                -- end
            else
                fallback()
            end
        end

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    if vim.fn.has("nvim-0.10.0") == 1 then
                        vim.snippet.expand(args.body) -- native snippets (Neovim v0.10+)
                    else
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<c-space>"] = cmp.mapping.complete(),
                ["<c-e>"] = cmp.mapping.abort(),

                ["<c-j>"] = cmp.mapping(do_next),
                ["<c-k>"] = cmp.mapping(do_prev),

                ["<c-n>"] = cmp.mapping(do_next),
                ["<c-p>"] = cmp.mapping(do_prev),

                -- Disabled in favor of the default mapping, allowing the completer to work more accurately.
                -- ["<tab>"] = cmp.mapping(do_next),
                -- ["<s-tab>"] = cmp.mapping(do_prev),

                ["<c-f>"] = cmp.mapping.scroll_docs(4),
                ["<c-b>"] = cmp.mapping.scroll_docs(-4),

                ["<c-d>"] = cmp.mapping.scroll_docs(4),
                ["<c-u>"] = cmp.mapping.scroll_docs(-4),

                ["<cr>"] = cmp.mapping.confirm({
                    -- behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = "codeium" },
                { name = "cmp_gl" },
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "path" },
            }, {
                { name = "buffer" },
            }),
            formatting = {
                expandable_indicator = true,
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        symbol_map = { Codeium = "" },
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
                -- format = require("scratch.core.helpers").cmp_format
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })

        -- Set configuration for specific filetype.
        --[[
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = "buffer" },
            }),
        })
        --]]

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                ["<c-j>"] = {
                    c = function(default)
                        if cmp.visible() then
                            return cmp.select_next_item()
                        end

                        default()
                    end,
                },
                ["<c-k>"] = {
                    c = function(default)
                        if cmp.visible() then
                            return cmp.select_prev_item()
                        end

                        default()
                    end,
                },
            }),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = {
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_partial_fuzzy_matching = false,
                disallow_partial_matching = false,
                disallow_prefix_unmatching = false,
                disallow_symbol_nonprefix_matching = false,
            },
        })
    end,
}
