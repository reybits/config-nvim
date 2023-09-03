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

require("lazy").setup({
    -- Gruvbox colortheme (must have)
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    },

    -- Shows hotkeys (must have)
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

    -- Completion
    "williamboman/mason.nvim",
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
        end,
    },

    -- Project tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        config = function()
            require("neo-tree").setup()
        end,
    },

    -- Interface for tree-sitter in Neovim
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },

    -- Fuzzy finder (must have)
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-tree/nvim-web-devicons",
            -- "nvim-telescope/telescope-fzf-native.nvim",
        }
    }

    --[[
  'wbthomason/packer.nvim',
  'rebelot/kanagawa.nvim',
  {
    'dracula/vim',
    lazy = false,
  },
  'nvim-tree/nvim-tree.lua',
  'nvim-lualine/lualine.nvim',
  'bluz71/vim-nightfly-colors',
  'vim-test/vim-test',
  'lewis6991/gitsigns.nvim',
  'preservim/vimux',
  'christoomey/vim-tmux-navigator',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  "rafamadriz/friendly-snippets",
  "github/copilot.vim",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "glepnir/lspsaga.nvim",
  --]]
})

--[[
require("lazy").setup({
    {
        "nvim-neorg/neorg",
        -- lazy-load on filetype
        ft = "norg",
        -- options for neorg. This will automatically call `require("neorg").setup(opts)`
        opts = {
            load = {
                ["core.defaults"] = {},
            },
        },
    },

    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        --config = function()
            --require("neoconf").setup()
        --end
    },

    {
        "folke/neodev.nvim",
    },

})
    ]]--
