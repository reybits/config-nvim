require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox', -- or use 'auto',
        component_separators = '', -- or { left = '', right = ''},
        section_separators = '', -- or { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = { 'neo-tree' },
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', 'filesize'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}

    },
    inactive_sections = {
        lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'location'}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

