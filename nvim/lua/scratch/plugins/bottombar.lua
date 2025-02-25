return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        --[[
        {
            "SmiteshP/nvim-navic",
            dependencies = {
                "neovim/nvim-lspconfig",
            },
        },
        --]]
    },
    config = function()
        local lualine = require("lualine")

        -- check for Lazy package upgrades
        local lazy_status = require("lazy.status")

        -- check for Mason package upgrades
        local function mason_status()
            local registry = require("mason-registry")
            if registry ~= nil then
                local installed = registry.get_installed_package_names()
                local outdated = 0

                for _, pkg in pairs(installed) do
                    local p = registry.get_package(pkg)
                    if p then
                        p:check_new_version(function(success, _)
                            if success then
                                outdated = outdated + 1
                            end
                        end)
                    end
                end

                if outdated ~= 0 then
                    return outdated
                end
            end

            return ""
        end

        local better_fn = require("lualine.components.filename"):extend()
        local highlight = require("lualine.highlight")

        function better_fn:init(options)
            better_fn.super.init(self, options)
            self.status_colors = {
                saved = highlight.create_component_highlight_group(
                    {}, -- { bg = "#228B22", fg = "#ffff00" },
                    "filename_status_saved",
                    self.options
                ),
                modified = highlight.create_component_highlight_group(
                    { fg = "#F05050" },
                    "filename_status_modified",
                    self.options
                ),
            }
            if self.options.color == nil then
                self.options.color = ""
            end
        end

        function better_fn:update_status()
            local data = better_fn.super.update_status(self)
            local color = vim.bo.modified and self.status_colors.modified
                or self.status_colors.saved
            data = highlight.component_format_highlight(color) .. data
            return data
        end

        --[[
        -- useful only if globalstatus = true
        local better_fn_inactive = better_fn:extend()
        function better_fn_inactive:init(options)
            better_fn_inactive.super.init(self, options)
            self.status_colors = {
                saved = highlight.create_component_highlight_group(
                    {},
                    "filename_status_saved",
                    self.options
                ),
                modified = highlight.create_component_highlight_group(
                    { fg = "#700000" },
                    "filename_status_modified",
                    self.options
                ),
            }
            if self.options.color == nil then
                self.options.color = ""
            end
        end
        --]]

        --[[
        local navic = require("nvim-navic")
        navic.setup({
            lsp = {
                auto_attach = true,
                preference = nil,
            },
            depth_limit = 2,
            depth_limit_indicator = "…",
            highlight = false,
        })
        --]]

        local fmt_progress = function(str)
            local percent = 0
            if str == "Top" then
                percent = 0
            elseif str == "Bot" then
                percent = 100
            else
                percent = str:gsub("%%", "")
            end

            local list = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
            local idx = 1 + math.floor((#list - 1) * percent / 100)
            -- print(str .. " -> " .. idx)
            return list[idx]
        end

        local function diff_cond()
            return vim.bo.buftype == "acwrite"
            -- local buf_name = vim.api.nvim_buf_get_name(0)
            -- local prefix = "gitsigns://"
            -- return buf_name:sub(1, #prefix) == prefix
        end
        local function not_diff_cond()
            return diff_cond() == false
        end

        lualine.setup({
            options = {
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = {
                    "NeogitStatus",
                    "NvimTree",
                    "TelescopePrompt",
                    "dashboard",
                    "starter",
                    "trouble",
                },
            },
            -- stylua: ignore
            sections = {
                lualine_a = {
                    { "mode",
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                        padding = { left = 1, right = 0 }
                    },
                },
                lualine_b = {
                    "branch",
                },
                lualine_c = {
                    { "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                        cond = not_diff_cond
                    },
                    { function() return "*diff (close with gq)*" end,
                        cond = diff_cond
                    },
                    { better_fn,
                        cond = not_diff_cond
                    },
                    --[[
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end
                    }
                    --]]
                },
                lualine_x = {
                    { "diff",
                        symbols = {
                            added = ' ',
                            modified = ' ',
                            removed = ' '
                        },
                        cond = not_diff_cond
                    },
                    { "diagnostics",
                        cond = not_diff_cond
                    },
                    { lazy_status.updates,
                        cond = function()
                            return not_diff_cond() and lazy_status.has_updates()
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    { mason_status,
                        icon = "󱌢",
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_y = {
                    { "fileformat",
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = not_diff_cond
                    },
                    { "encoding",
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = not_diff_cond
                    },
                },
                lualine_z = {
                    { "selectioncount",
                        fmt = function(str)
                            return str:len() > 0 and "s:" .. str or ""
                        end,
                        separator = " ",
                        padding = { left = 0, right = 0 },
                    },
                    { "location",
                        fmt = function(str)
                            return str:gsub("%s+", "")
                        end,
                        separator = " ",
                        padding = { left = 0, right = 0 },
                    },
                    { "progress",
                        fmt = fmt_progress,
                        padding = { left = 0, right = 1 },
                    },
                },
            },
            -- stylua: ignore
            --[[
            -- useful only if globalstatus = true
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                    },
                    { better_fn },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            --]]
            -- stylua: ignore
            tabline = {
                --[[
                lualine_b = {
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end
                    }
                },
                --]]
                lualine_z = {
                    { "tabs",
                        cond = function()
                            return #vim.fn.gettabinfo() > 1
                        end,
                    },
                },
            },
        })

        vim.opt.showtabline = 1 -- override lualine's settings
    end,
}
