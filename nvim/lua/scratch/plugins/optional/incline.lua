--
-- Incline is a plugin for creating lightweight floating statuslines
--

return {
    "b0o/incline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = {
        "BufRead",
    },
    config = function()
        require("incline").setup({
            render = function(props)
                local bufname = vim.api.nvim_buf_get_name(props.buf)
                if bufname == nil then
                    -- TODO: Remove notification after debugging
                    vim.notify("[Incline] Wrong buffer name", vim.log.level.WARNIG)
                    bufname = ""
                end

                local filename = vim.fn.fnamemodify(bufname, ":t")
                if filename == "" then
                    -- TODO: Remove notification after debugging
                    vim.notify("[Incline] Wrong file name", vim.log.level.WARNIG)
                    filename = "[No Name]"
                end

                local devicons = require("nvim-web-devicons")
                local ft_icon, ft_color = devicons.get_icon_color(filename)

                local get_mod_prop = function()
                    local mod_icon = ""
                    local mod_color = "white"
                    local mod_gui = "normal"
                    if vim.bo[props.buf].modified then
                        mod_icon = " ●"
                        mod_color = "#F05050"
                        mod_gui = "bold,italic"
                    end
                    return mod_icon, mod_color, mod_gui
                end

                local mod_icon, mod_color, mod_gui = get_mod_prop()

                return {
                    { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
                    {
                        filename .. mod_icon,
                        guifg = mod_color,
                        gui = mod_gui,
                    },
                }
            end,
            hide = {
                only_win = "count_ignored",
            },
            window = {
                margin = {
                    horizontal = 0,
                    vertical = 0,
                },
            },
        })
    end,
}
