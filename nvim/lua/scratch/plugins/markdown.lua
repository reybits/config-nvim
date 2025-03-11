-- disable plugin by default
local render_markdown = false

local ToggleOption = require("scratch.core.toggleopt")

local toggle_markdown = ToggleOption:new("<leader>oem", function(state)
    if state then
        vim.cmd("RenderMarkdown enable")
    else
        vim.cmd("RenderMarkdown disable")
    end
end, "Render Markdown", render_markdown)

return {
    -- inline preview
    {
        "MeanderingProgrammer/render-markdown.nvim",
        cmd = {
            "RenderMarkdown",
        },
        ft = {
            "markdown",
        },
        keys = {
            {
                mode = "n",
                toggle_markdown:getMapping(),
                toggle_markdown:getToggleFunc(),
                desc = toggle_markdown:getCurrentDescription(),
            },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local rendermd = require("render-markdown")

            rendermd.setup({
                -- render_modes = { "n", "v", "i", "c" },
                preset = "obsidian",
                sign = {
                    enabled = false,
                },
                code = {
                    style = "normal",
                    border = "thick",
                },
                heading = {
                    border = true,
                    -- position = "inline",
                },
                quote = {
                    repeat_linebreak = true,
                },
                pipe_table = {
                    preset = "round",
                    alignment_indicator = "┅",
                },
                win_options = {
                    showbreak = { default = "", rendered = "  " },
                    breakindent = { default = false, rendered = true },
                    breakindentopt = { default = "", rendered = "" },
                    conceallevel = {
                        default = vim.api.nvim_get_option_value("conceallevel", {}),
                        rendered = 3,
                    },
                    concealcursor = {
                        default = vim.api.nvim_get_option_value("concealcursor", {}),
                        rendered = "",
                    },
                },
            })

            if render_markdown == false then
                rendermd.disable()
            end
        end,
    },

    -- browser preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        ft = {
            "markdown",
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
