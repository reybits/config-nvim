---@diagnostic disable: missing-fields
return {
    -- inline preview
    {
        "OXY2DEV/markview.nvim",
        ft = {
            "markdown",
            "codecompanion",
            "Avante",
        },
        cmd = {
            "Markview",
        },
        keys = {
            {
                "<leader>omm",
                "<cmd>Markview toggle<cr>",
                desc = "Inline Markdown",
            },
            -- INFO: Disabled in favor of browser preview.
            -- Look to "iamcco/markdown-preview.nvim" below for browser preview.
            -- {
            --     "<leader>omp",
            --     "<cmd>Markview splitToggle<cr>",
            --     desc = "Preview Markdown",
            -- },
        },
        -- dependencies = {
        --     -- Completion for `blink.cmp`
        --     "saghen/blink.cmp",
        -- },
        init = function()
            local wk = require("which-key")
            wk.add({
                { "<leader>om", group = "Markdown" },
            })
        end,
        config = function()
            local presets = require("markview.presets")

            require("markview").setup({
                preview = {
                    enable = false,
                    icon_provider = "devicons", -- "internal", -- "mini" or "devicons"
                    filetypes = { "markdown", "codecompanion", "Avante" },
                    ignore_buftypes = {},
                },
                markdown = {
                    -- headings = presets.headings.arrowed,
                    -- headings = presets.headings.numbered,
                    headings = {
                        shift_width = 0,
                        heading_1 = { icon = " 󰎤 " }, -- [%d] " },
                        heading_2 = { icon = " 󰎧 " }, -- [%d.%d] " },
                        heading_3 = { icon = " 󰎪 " }, -- [%d.%d.%d] " },
                        heading_4 = { icon = " 󰎭 " }, -- [%d.%d.%d.%d] " },
                        heading_5 = { icon = " 󰎱 " }, -- [%d.%d.%d.%d.%d] " },
                        heading_6 = { icon = " 󰎳 " }, -- [%d.%d.%d.%d.%d.%d] " },
                    },

                    tables = presets.tables.rounded,

                    list_items = {
                        shift_width = function(buffer, item)
                            ---@type integer Parent list items indent. Must be at least 1.
                            local parent_indnet =
                                math.max(1, item.indent - vim.bo[buffer].shiftwidth)
                            return item.indent * (1 / (parent_indnet * 2))
                        end,
                    },
                },
                code_blocks = {
                    style = "simple",
                },
            })
        end,
    },

    -- browser preview
    {
        "iamcco/markdown-preview.nvim",
        ft = {
            "markdown",
        },
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        keys = {
            {
                "<leader>omp",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Preview Markdown in Browser",
            },
        },
        build = function(plugin)
            if vim.fn.executable("npx") then
                vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.cmd([[Lazy load markdown-preview.nvim]])
                vim.fn["mkdp#util#install"]()
            end
        end,
        init = function()
            if vim.fn.executable("npx") then
                vim.g.mkdp_filetypes = { "markdown" }
            end
        end,
    },
}
