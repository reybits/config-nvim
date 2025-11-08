local function dismissCopilotSuggetion()
    if package.loaded["_copilot"] ~= nil then
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Plug>(copilot-dismiss)", true, true, true),
            "i",
            false
        )
    end

    -- if package.loaded["copilot.api"] ~= nil then
    --     require("copilot.suggestion").dismiss()
    -- end
end

return {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    dependencies = {
        -- optional: provides snippets for the snippet source
        -- "rafamadriz/friendly-snippets",

        "xzbdmw/colorful-menu.nvim",

        "folke/lazydev.nvim",
        "moyiz/blink-emoji.nvim",

        -- "fang2hou/blink-copilot",
        -- "giuxtaposition/blink-cmp-copilot",
    },

    event = {
        "InsertEnter",
        "CmdlineEnter",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- Disable blink-cmp for some filetype
        enabled = function()
            return not vim.tbl_contains(
                { "typr", "DressingInput", "copilot-chat" },
                vim.bo.filetype
            ) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
        end,

        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-e: Hide menu
        -- C-k: Toggle signature help
        --
        -- See the full "keymap" documentation for information on defining your own keymap.
        -- keymap = { preset = "default" },
        keymap = {
            -- preset = "enter",
            ["<c-space>"] = {
                function()
                    dismissCopilotSuggetion()
                    return false -- passthrough to the next command
                end,
                "show",
                "hide",
            },

            ["<c-h>"] = { "show_documentation", "hide_documentation" },

            ["<c-e>"] = { "hide", "fallback" },

            ["<c-j>"] = { "snippet_forward", "select_next", "fallback" },
            ["<c-k>"] = { "snippet_backward", "select_prev", "fallback" },

            ["<c-n>"] = { "snippet_forward", "select_next", "fallback" },
            ["<c-p>"] = { "snippet_backward", "select_prev", "fallback" },

            ["<c-f>"] = { "scroll_documentation_down", "fallback" },
            ["<c-b>"] = { "scroll_documentation_up", "fallback" },

            ["<c-d>"] = { "scroll_documentation_down", "fallback" },
            ["<c-u>"] = { "scroll_documentation_up", "fallback" },

            -- TODO: Remove this mapping and use <tab> instead.
            ["<cr>"] = { "accept", "fallback" },

            -- Use <tab> to accept completion to comply with github-copilot.
            ["<tab>"] = { "accept", "fallback" },
        },

        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },

            -- Show documentation when selecting a completion item
            documentation = {
                -- window = { border = "single" },
                auto_show = true,
                -- auto_show_delay_ms = 500,
                -- treesitter_highlighting = false, -- disable if high CPU usage or stuttering when opening the documentation
            },

            ghost_text = {
                -- Show ghost text only when the completion menu is visible; hide otherwise.
                enabled = true,
                show_with_menu = false,
                show_without_menu = false,
            },

            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },

            menu = {
                -- border = "single",

                -- Disable auto show completion menu by default...
                auto_show = false,
                -- or Automatically show completion menu and dismiss Copilot suggestion initially.
                -- auto_show = function(ctx)
                --     dismissCopilotSuggetion()
                --     return true
                -- end,

                draw = {
                    -- We don't need label_description now because label and label_description are already
                    -- combined together in label by colorful-menu.nvim.
                    -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                    columns = {
                        { "kind_icon" },
                        { "label", gap = 1 },
                    },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },

        signature = {
            enabled = true,
            -- show_documentation = false, -- show only the signature, and not the documentation
            -- window = { border = "single" },
        },

        cmdline = {
            keymap = {
                -- ["<cr>"] = { "accept", "fallback" },
                ["<tab>"] = { "show", "accept" },
                ["<c-j>"] = { "select_next", "fallback_to_mappings" },
                ["<c-k>"] = { "select_prev", "fallback_to_mappings" },
            },
            completion = {
                menu = {
                    auto_show = false,
                    --[[
                    auto_show = function(ctx)
                        return vim.fn.getcmdtype() == ":"
                            -- enable for inputs as well, with:
                            -- or vim.fn.getcmdtype() == '@'
                            -- requires by "monkoose/neocodeium"
                            or ctx.mode ~= "default"
                    end,
                    --]]
                },
            },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            -- Setup sources according to enabled AI related plugins
            default = function()
                local sources = { "lazydev", "lsp", "path", "snippets", "buffer", "emoji" }

                -- check is plugin 'github/copilot.vim' loaded
                -- if package.loaded["_copilot"] ~= nil then
                --     table.insert(sources, "copilot")
                -- end

                -- check is plugin 'zbirenbaum/copilot.lua' loaded
                -- if package.loaded["copilot.api"] ~= nil then
                --     table.insert(sources, "copilot")
                -- end

                return sources
            end,

            providers = {
                -- defaults to `{ 'buffer' }`
                lsp = {
                    fallbacks = {},
                },

                snippets = {
                    -- Hide snippets after trigger character
                    should_show_items = function(ctx)
                        return ctx.trigger.initial_kind ~= "trigger_character"
                    end,
                },

                -- 'fang2hou/blink-copilot' + 'github/copilot.vim'
                -- copilot = {
                --     name = "copilot",
                --     enabled = function()
                --         return package.loaded["_copilot"] ~= nil
                --     end,
                --     module = "blink-copilot",
                --     score_offset = 100,
                --     async = true,
                -- },

                -- 'giuxtaposition/blink-cmp-copilot' + 'zbirenbaum/copilot.lua'
                -- copilot = {
                --     name = "copilot",
                --     enabled = function()
                --         return package.loaded["copilot.api"] ~= nil
                --     end,
                --     module = "blink-cmp-copilot",
                --     score_offset = 100,
                --     async = true,
                -- },

                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },

                -- path = {
                --     opts = {
                --         -- Path completion from cwd instead of current buffer's directory
                --         get_cwd = function(_)
                --             return vim.fn.getcwd()
                --         end,
                --     },
                -- },

                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 15, -- Tune by preference
                    opts = { insert = true }, -- Insert emoji (default) or complete its name
                    should_show_items = function()
                        -- By default, enabled for all file-types.
                        -- Enable emoji completion only for git commits, markdown, and plain-text.
                        return vim.tbl_contains({ "gitcommit", "markdown", "text" }, vim.o.filetype)
                    end,
                },
            },
        },

        -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
    },
    opts_extend = { "sources.default" },
}
