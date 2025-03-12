return {
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    dependencies = {
        -- optional: provides snippets for the snippet source
        -- "rafamadriz/friendly-snippets",

        "xzbdmw/colorful-menu.nvim",
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
            return not vim.tbl_contains({ "typr" }, vim.bo.filetype)
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
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
            ["<c-space>"] = { "show", "show_documentation", "hide_documentation" },

            ["<c-e>"] = { "hide", "fallback" },

            ["<c-j>"] = { "select_next", "fallback_to_mappings" },
            ["<c-k>"] = { "select_prev", "fallback_to_mappings" },

            ["<c-n>"] = { "select_next", "fallback_to_mappings" },
            ["<c-p>"] = { "select_prev", "fallback_to_mappings" },

            ["<tab>"] = { "snippet_forward", "fallback" },
            ["<s-tab>"] = { "snippet_backward", "fallback" },

            ["<c-f>"] = { "scroll_documentation_down", "fallback" },
            ["<c-b>"] = { "scroll_documentation_up", "fallback" },

            ["<c-d>"] = { "scroll_documentation_down", "fallback" },
            ["<c-u>"] = { "scroll_documentation_up", "fallback" },

            ["<cr>"] = { "accept", "fallback" },
        },

        completion = {
            list = {
                selection = { preselect = true, auto_insert = false },
            },

            -- Show documentation when selecting a completion item
            documentation = {
                -- window = { border = "single" },
                auto_show = false,
                -- auto_show_delay_ms = 500,
                -- treesitter_highlighting = false, -- disable if high CPU usage or stuttering when opening the documentation
            },

            -- Display a preview of the selected item on the current line
            ghost_text = {
                enabled = true,
            },

            accept = { auto_brackets = { enabled = false } },

            menu = {
                -- border = "single",
                draw = {
                    -- We don't need label_description now because label and label_description are already
                    -- combined together in label by colorful-menu.nvim.
                    -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
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
                    auto_show = function()
                        return vim.fn.getcmdtype() == ":"
                        -- enable for inputs as well, with:
                        -- or vim.fn.getcmdtype() == '@'
                    end,
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
            default = { "lsp", "path", "snippets", "buffer" },
        },

        -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
