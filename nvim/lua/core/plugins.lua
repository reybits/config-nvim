local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup({
    -- Gruvbox colortheme (must have)
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
		config = function()
			vim.o.termguicolors = true
			vim.cmd([[colorscheme gruvbox]])
		end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },

    {
        'nvim-treesitter/nvim-treesitter',
    },

    -- Git plugin for Vim
    {
        "tpope/vim-fugitive",
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            {
                "williamboman/mason.nvim",
                config = true,
            },

            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
                event = "LspAttach",
                opts = {},
            },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp", -- Adds LSP completion capabilities
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",

            -- vsni
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",

            -- luasnip
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",

            -- "rafamadriz/friendly-snippets", -- Adds a number of user-friendly snippets
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    --{ "folke/neoconf.nvim", cmd = "Neoconf" },
    --{ "folke/neodev.nvim", },
})
