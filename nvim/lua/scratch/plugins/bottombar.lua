return {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local highlight = require("lualine.highlight")

        local better_fn = require("lualine.components.filename"):extend()
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

        local navic = require("nvim-navic")

        lualine.setup({
            options = {
                globalstatus = false,
                disabled_filetypes = {
                    "NvimTree",
                    "NeogitStatus",
                    "starter",
                    "dashboard",
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
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                    },
                    -- { "filename" },
                    { better_fn }
                },
                lualine_x = {
                    "diff",
                    "diagnostics",
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_y = {
                    { "fileformat",
                        separator = "",
                        padding = { left = 0, right = 1 }
                    },
                    { "encoding",
                        separator = "",
                        padding = { left = 0, right = 1 }
                    },
                },
                lualine_z = {
                    { "selectioncount",
                        fmt = function(str)
                            return str:len() > 0
                                and "s:" .. str
                                or ""
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
                        fmt = function(str)
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
                        end,
                        padding = { left = 0, right = 1 },
                    },
                },
            },
            -- stylua: ignore
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { "filetype",
                        icon_only = true,
                        separator = "",
                        padding = { left = 1, right = 0 },
                    },
                    -- { "filename" },
                    -- { better_fn_inactive }
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    --[[
                    { "location",
                        fmt = function(str)
                            return str:gsub("%s+", "")
                        end,
                        separator = " ",
                        padding = { left = 0, right = 0 },
                    },
                    --]]
                },
            },
            tabline = {
                lualine_a = { "filename" },
                lualine_b = {
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                    },
                },
                lualine_z = { "tabs" },
            },
        })
    end,
}
