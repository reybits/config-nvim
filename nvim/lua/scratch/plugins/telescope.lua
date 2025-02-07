return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        "folke/trouble.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = {
        "Telescope",
        "DashBrowse",
        "DashFiles",
        "DashRecent",
        "DashGrep",
    },
    -- stylua: ignore
    keys = {
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>ff", function()
                require("telescope.builtin").find_files({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Find Files (cwd)" },

        { "<leader>fC", function ()
                require("telescope.builtin").find_files({
                    cwd = vim.fn.stdpath("config")
                })
            end, desc = "Find Neovim Files" },

        { "<leader>fP", function()
                require("telescope.builtin").find_files({
                    cwd = require("lazy.core.config").options.root,
                })
            end, desc = "Find plugin file" },

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

        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find TODO/INFO/..." },

        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local actions_layout = require("telescope.actions.layout")
        local trouble = require("trouble.sources.telescope")

        -- Dashboard commands support
        vim.api.nvim_create_user_command("DashBrowse", function()
            require("telescope.builtin").find_files({
                preview = { hide_on_startup = true },
                cwd = "",
            })
        end, {})
        vim.api.nvim_create_user_command("DashFiles", function()
            require("telescope.builtin").find_files()
        end, {})
        vim.api.nvim_create_user_command("DashRecent", function()
            require("telescope.builtin").oldfiles()
        end, {})
        vim.api.nvim_create_user_command("DashGrep", function()
            require("telescope.builtin").live_grep()
        end, {})

        telescope.setup({
            defaults = {
                scroll_strategy = "limit",
                winblend = 20,
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        width = 0.96,
                        height = 0.96,
                        preview_cutoff = 25,
                        preview_height = 0.6,
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
                        ["<c-t>"] = trouble.open,
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
                    -- sort_lastused = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer,
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
            },
            extensions = {
                -- stylua: ignore
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- "smart_case" or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
