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

        -- update recording status in lualine
        vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
            callback = function()
                -- A small delay is needed so that reg_recording() has time to update.
                vim.defer_fn(function()
                    require("lualine").refresh()
                end, 50)
            end,
        })

        -- check for Mason package upgrades (cached, refreshes every 10 min)
        local mason_cached_result = ""
        local mason_last_check = 0
        local mason_cache_ttl = 600 -- seconds

        local function mason_status()
            local now = os.time()
            if now - mason_last_check < mason_cache_ttl then
                return mason_cached_result
            end
            mason_last_check = now

            if package.loaded["mason"] == nil then
                mason_cached_result = ""
                return mason_cached_result
            end

            local registry = require("mason-registry")
            if registry == nil then
                mason_cached_result = ""
                return mason_cached_result
            end

            local installed = registry.get_installed_package_names()
            local outdated = 0

            for _, pkg in pairs(installed) do
                local p = registry.get_package(pkg)
                if p then
                    local new = p:get_latest_version()
                    local old = p:get_installed_version()
                    if new ~= old then
                        outdated = outdated + 1
                    end
                end
            end

            mason_cached_result = outdated ~= 0 and outdated or ""
            return mason_cached_result
        end

        --[[
        -- make TS context string
        local function ts_context_is_enabled()
            return package.loaded["nvim-treesitter"] ~= nil
        end

        local function ts_context()
            local f = require("nvim-treesitter").statusline({
                indicator_size = 100,
                type_patterns = {
                    "class",
                    "function",
                    "method",
                    "interface",
                    "type_spec",
                    "table",
                    "if_statement",
                    "for_statement",
                    "for_in_statement",
                },
                separator = " » ",
                allow_duplicates = false,
            })

            if f == nil or f == "" then
                return ""
            end

            return string.format(" %s", f) -- convert to string, it may be a empty ts node
        end
        --]]

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

        --[[
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
        --]]

        local function not_acwrite()
            return vim.bo.buftype ~= "acwrite"
        end

        local function not_filetypes()
            return not vim.bo.filetype:match("^Telescope")
                and not vim.bo.filetype:match("^Neogit")
        end

        lualine.setup({
            options = {
                theme = "material",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = {
                    -- "NeogitStatus",
                    "NvimTree",
                    -- "TelescopePrompt",
                    "dashboard",
                    "neo-tree",
                    "starter",
                    -- "trouble",
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
                    { -- show recording register
                        function()
                            local reg = vim.fn.reg_recording()
                            if reg == '' then
                                return ''
                            end
                            return '@' .. reg
                        end,
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
                        cond = not_acwrite
                    },
                    { better_fn,
                        fmt = function(str)
                            if not_acwrite() then
                                return str
                            end
                            return "-= close with <q> =-"
                        end,
                        cond = not_filetypes
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
                            added = '+', --  ',
                            modified = '*', -- ',
                            removed = '-', --  '
                        },
                        cond = function()
                            return not_acwrite() and not_filetypes()
                        end
                    },
                    { "diagnostics",
                        cond = function()
                            return not_acwrite() and not_filetypes()
                        end
                    },
                    { lazy_status.updates,
                        cond = function()
                            return not_acwrite() and not_filetypes() and lazy_status.has_updates()
                        end,
                        on_click = function()
                            vim.cmd("Lazy")
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    { mason_status,
                        cond = function()
                            return not_acwrite() and not_filetypes()
                        end,
                        icon = "󱌢",
                        on_click = function()
                            vim.cmd("Mason")
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    { -- Show Copilot status.
                        function()
                            return ""
                        end,
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = function()
                            local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                            for _, client in ipairs(clients) do
                                if client.name == "copilot" then
                                    return true
                                end
                            end
                            return false
                        end
                    },
                },
                lualine_y = {
                    { -- Show autoformat status.
                        function()
                            if vim.g.autoformat_toggle == nil or vim.g.autoformat_toggle then
                                return "󰗴"
                            end
                            return "󰉥"
                        end,
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = not_filetypes
                    },
                    { -- Show wrap status.
                        function()
                            if vim.wo.wrap then
                                return "󰖶"
                            end
                            return "󰯟"
                        end,
                        separator = "",
                        padding = { left = 0, right = 1 },
                    },
                    { "fileformat",
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = not_acwrite
                    },
                    { "encoding",
                        separator = "",
                        padding = { left = 0, right = 1 },
                        cond = not_acwrite
                    },
                },
                lualine_z = {
                    { "searchcount",
                        maxcount = 999999,
                        separator = "|",
                        padding = { left = 0, right = 0 },
                    },
                    { "selectioncount",
                        separator = "|",
                        padding = { left = 0, right = 0 },
                    },
                    { "location",
                        fmt = function(str)
                            return str:gsub("%s+", "")
                        end,
                        separator = "|",
                        padding = { left = 0, right = 1 },
                    },
                    -- { "progress",
                    --     fmt = fmt_progress,
                    --     padding = { left = 0, right = 1 },
                    -- },
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
                            return ts_context()
                        end,
                        cond = function()
                            return ts_context_is_enabled()
                        end,
                    },
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

        -- override lualine's settings
        vim.opt.showtabline = 1
    end,
}
