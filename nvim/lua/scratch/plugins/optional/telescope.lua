local M = {}

-- Custom Telescope file finder with <c-i> / <c-h> to toggle hidden/ignored files.
M.toggle_find_files = function(opts, show_ignore, show_hidden)
    opts = opts or {}

    show_ignore = vim.F.if_nil(show_ignore, false)
    show_hidden = vim.F.if_nil(show_hidden, false)

    opts.attach_mappings = function(_, map)
        map({ "n", "i" }, "<m-i>", function(prompt_bufnr)
            local prompt = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            show_ignore = not show_ignore
            M.toggle_find_files({ default_text = prompt }, show_ignore, show_hidden)
        end, { desc = "Toggle Ignore Files" })

        map({ "n", "i" }, "<m-h>", function(prompt_bufnr)
            local prompt = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            show_hidden = not show_hidden
            M.toggle_find_files({ default_text = prompt }, show_ignore, show_hidden)
        end, { desc = "Toggle show_Hidden Files" })
        return true
    end

    opts.prompt_title = "Find Files"
    if show_hidden or show_ignore then
        opts.prompt_title = opts.prompt_title .. " <"
        if show_ignore then
            opts.no_ignore = true
            opts.prompt_title = opts.prompt_title .. "I"
        end
        if show_hidden then
            opts.hidden = true
            opts.prompt_title = opts.prompt_title .. "H"
        end
        opts.prompt_title = opts.prompt_title .. ">"
    end

    require("telescope.builtin").find_files(opts)
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    event = "BufRead",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        -- "folke/todo-comments.nvim",

        "nvim-telescope/telescope-ui-select.nvim",

        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = {
        "Telescope",
        "DashFiles",
        "DashGrep",
        "UiHandleSelect",
    },
    -- stylua: ignore
    keys = {
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },

        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

        { "<leader><space>", function() M.toggle_find_files() end, desc = "Project Files" },
        { "<leader>fp", function() M.toggle_find_files() end, desc = "Project Files" },

        { "<leader>ff", function()
                require("telescope.builtin").find_files({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Current Dir Files" },

        { "<leader>fC", function()
                require("telescope.builtin").find_files({
                    cwd = vim.fn.stdpath("config")
                })
            end, desc = "Neovim Config Files" },

        { "<leader>fP", function()
                require("telescope.builtin").find_files({
                    cwd = require("lazy.core.config").options.root,
                })
            end, desc = "Neovim Plugin Files" },

        { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Search Buffer" },

        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>sG", function()
                require("telescope.builtin").live_grep({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Live Grep (cwd)" },

        { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
        { "<leader>sW", function()
                require("telescope.builtin").grep_string({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Grep String (cwd)" },

        -- Key binding for TODO comments has been moved to the "folke/todo-comments.nvim" plugin.
        -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find TODO/INFO/..." },

        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
        { "<leader>sm", function()
                require("telescope.builtin").man_pages({
                    sections = { "ALL" },
                })
            end, desc = "Search Man" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },

        -- { "<leader>cs", function()
        --         require("telescope.builtin").lsp_document_symbols({
        --             symbol_width = 50,
        --             symbol_type_width = 11,
        --             show_line = true
        --         })
        --     end, desc = "Show Document Symbols" },
        -- { "<leader>ci", function()
        --         require("telescope.builtin").lsp_incoming_calls({
        --             fname_width = 50,
        --             show_line = true
        --         })
        --     end, desc = "Show Incoming Calls" },
        -- { "<leader>cr", function()
        --         require("telescope.builtin").lsp_references({
        --             fname_width = 40,
        --             show_line = true
        --         })
        --     end, desc = "Show References" },
        -- { "<leader>cD", "<cmd>Telescope diagnostics<cr>", desc = "Show Diagnostics" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local actions_layout = require("telescope.actions.layout")
        -- local trouble = require("trouble.sources.telescope")

        -- Support for dashboard-specific commands.
        vim.api.nvim_create_user_command("DashFiles", function(opts)
            opts = opts or {}
            local args = {}
            for key, value in string.gmatch(opts.args, "([^%s=]+)=([^{%s]+)") do
                args[key] = value
            end
            require("telescope.builtin").find_files(args)
        end, { nargs = "*" })
        vim.api.nvim_create_user_command("DashGrep", function()
            require("telescope.builtin").live_grep()
        end, {})

        telescope.setup({
            defaults = {
                scroll_strategy = "limit",
                winblend = 20,
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.96,
                    height = 0.96,
                    vertical = {
                        preview_cutoff = 25,
                        preview_height = 0.6,
                    },
                    horizontal = {
                        preview_cutoff = 25,
                        preview_width = 0.7,
                    },
                },
                path_display = { "truncate" },
                prompt_prefix = "  ",
                selection_caret = "󰜴 ",
                initial_mode = "insert",
                color_devicons = true,
                mappings = {
                    i = {
                        ["<c-c>"] = false,
                        ["<down>"] = false,
                        ["<up>"] = false,
                        ["<pageup>"] = false,
                        ["<pagedown>"] = false,
                        ["<esc>"] = actions.close,
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-n>"] = actions.cycle_history_next,
                        ["<c-p>"] = actions.cycle_history_prev,
                        -- ["<c-t>"] = trouble.open,
                        ["<m-p>"] = actions_layout.toggle_preview,
                    },
                },
                preview = {
                    mime_hook = function(filepath, bufnr, opts)
                        local is_image = function(path)
                            local image_extensions = { "png", "jpg", "jpeg" } -- Supported image formats
                            local split_path = vim.split(path:lower(), ".", { plain = true })
                            local extension = split_path[#split_path]
                            return vim.tbl_contains(image_extensions, extension)
                        end
                        if is_image(filepath) then
                            local viewer = "catimg"
                            if vim.fn.executable(viewer) == 1 then
                                local term = vim.api.nvim_open_term(bufnr, {})
                                local function send_output(_, data, _)
                                    for _, d in ipairs(data) do
                                        vim.api.nvim_chan_send(term, d .. "\r\n")
                                    end
                                end

                                local width = vim.api.nvim_win_get_width(opts.winid)
                                vim.fn.jobstart({
                                    viewer,
                                    "-w " .. tostring(width),
                                    filepath, -- Terminal image viewer command
                                }, {
                                    on_stdout = send_output,
                                    stdout_buffered = true,
                                    pty = true,
                                })
                            else
                                require("telescope.previewers.utils").set_preview_message(
                                    bufnr,
                                    opts.winid,
                                    "Viewer '" .. viewer .. "' not found!"
                                )
                            end
                        else
                            require("telescope.previewers.utils").set_preview_message(
                                bufnr,
                                opts.winid,
                                "Binary cannot be previewed"
                            )
                        end
                    end,
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<c-x>"] = actions.delete_buffer,
                        },
                    },
                    previewer = true,
                },
                current_buffer_fuzzy_find = {
                    previewer = true,
                },
                live_grep = {
                    previewer = true,
                },
                grep_string = {
                    previewer = true,
                },
                colorscheme = {
                    enable_preview = true,
                },
                lsp_document_symbols = {
                    previewer = true,
                    layout_strategy = "horizontal",
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),

                    -- pseudo code / specification for writing custom displays,
                    -- like the one for "codeactions" available on site:
                    -- https://github.com/nvim-telescope/telescope-ui-select.nvim?tab=readme-ov-file#telescope-setup-and-configuration
                },

                -- stylua: ignore
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- "smart_case" or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                },
            },
        })

        local is_ui_select_registered = false
        local function register_ui_select()
            if is_ui_select_registered == false then
                is_ui_select_registered = true
                telescope.load_extension("ui-select")
            end
        end

        -- Create command to register vim.ui.select handler
        vim.api.nvim_create_user_command("UiHandleSelect", function()
            register_ui_select()
        end, {})

        -- set telescope as ui-select's default picker
        register_ui_select()

        telescope.load_extension("fzf")
    end,
}
