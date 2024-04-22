return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local better_filename = require("lualine.components.filename"):extend()
        local highlight = require("lualine.highlight")

        function better_filename:init(options)
            better_filename.super.init(self, options)
            self.status_colors = {
                saved = highlight.create_component_highlight_group(
                    -- with background color
                    -- { bg = "#228B22" },
                    -- or without background color
                    {},
                    "filename_status_saved",
                    self.options
                ),
                modified = highlight.create_component_highlight_group(
                    { bg = "#C70039" },
                    "filename_status_modified",
                    self.options
                ),
            }
            if self.options.color == nil then
                self.options.color = ""
            end
        end

        function better_filename:update_status()
            local data = better_filename.super.update_status(self)
            local color = vim.bo.modified and self.status_colors.modified
                or self.status_colors.saved
            data = highlight.component_format_highlight(color) .. data
            return data
        end

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
                    { better_filename }
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
                    { "filename" },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    { "location",
                        fmt = function(str)
                            return str:gsub("%s+", "")
                        end,
                        separator = " ",
                        padding = { left = 0, right = 0 },
                    },
                },
            },
        })
    end,
}
