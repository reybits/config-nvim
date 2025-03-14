# Nvim from Scratch

[![Plugins](https://dotfyle.com/reybits/config-nvim-nvim/badges/plugins?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)
[![leaderkey](https://dotfyle.com/reybits/config-nvim-nvim/badges/leaderkey?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)
[![plugin-manager](https://dotfyle.com/reybits/config-nvim-nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)

This repository contains my custom Neovim configuration for Linux, macOS, and potentially Windows. The setup is built from scratch and includes only the plugins I actively use in my workflow. I primarily use Neovim as a C++ IDE for cross-platform game development.

For the best experience, use it alongside my [config-tmux](https://github.com/reybits/config-tmux.git) repository.

Kanagawa theme:
![kanagawa theme](https://github.com/reybits/config-nvim/blob/master/nvim-kanagawa.png?raw=true)

Nightfox theme:
![nightfox theme](https://github.com/reybits/config-nvim/blob/master/nvim-nightfox.png?raw=true)

## Install

```sh
git clone https://github.com/reybits/config-nvim.git ~/.config/nvim
```

## Features

- Plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim.git).
- Tool manager via [mason.nvim](https://github.com/williamboman/mason.nvim).
- Startup screen via [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim).
- Colorscheme via [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) ([nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) also available).
- Nice statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
- Scratchpad via [scratchpad.nvim](https://github.com/athar-qadri/scratchpad.nvim).
- Blind typing trainer via [typr](https://github.com/nvzone/typ).
- Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- Code auto-completion via [blink-cmp](https://github.com/Saghen/blink.cmp) ~~[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)~~.
- Code debugging via [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) and [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
- Fast navigation, lookup, and more via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) with fzf or [fzf-lua](https://github.com/ibhagwan/fzf-lua).
- Buffer bookmarks via [harpoon](https://github.com/ThePrimeagen/harpoon) v2.
- Git integration via [neogit](https://github.com/NeogitOrg/neogit) and [vim-fugitive](https://github.com/tpope/vim-fugitive) or [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim).
- Code commenting via [Comment.nvim](https://github.com/numToStr/Comment.nvim).
- File tree explorer via [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
- Undo tree explorer via [undotree](https://github.com/mbbill/undotree).
- Optional folding via [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo).
- Mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvi).
- Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- Markdown writing and previewing via [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
- And more...

## Customize

To customize plugins, enable, or disable integration with other tools, inside the `nvim/lua/scratch/custom` directory, create a `plugin-name.lua` file with the plugin name and add custom settings.

### Navigation related

By default, Telescope is used as the navigation plugin, you can change this by creating a `fuzzy.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/fuzzy.lua

return {
    -- Enable Fzf-lua
    { "ibhagwan/fzf-lua", enabled = true },

    -- Disable Telescope
    { "nvim-telescope/telescope.nvim", enabled = false },
```

### Git related

By default, Neogit and vim-fugitive is used as the Git plugin. However, you can change this by creating a `git.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/git.lua

return {
    -- Enable LazyGit instead of Neogit and vim-fugitive
    { "kdheepak/lazygit.nvim", enabled = true },
    { "NeogitOrg/neogit", enabled = false },
    { "tpope/vim-fugitive", enabled = false },

    -- Disable neogit and enable vim-fugitive and its companion plugin
    { "NeogitOrg/neogit", enabled = false },
    { "tpope/vim-rhubarb", enabled = true },
    { "rbong/vim-flog", enabled = true },
}
```

### AI related

By default, both Copilot and Codeium plugins are disabled. To enable them, create an `AI.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/AI.lua

return {
    -- Enable Copilot Chat
    { "CopilotC-Nvim/CopilotChat.nvim", enabled = true },

    -- Enable Copilot with integration into the completion menu via blink-cmp
    { "github/copilot.vim", enabled = true },

    -- or enable Codeium with nvim-cmp support without the completion menu,
    -- using mappings instead:
    -- <tab> to accept suggestion
    -- <a-e> to cycle through suggestions
    { "monkoose/neocodeium", enabled = true },
}
```

### Folding related

Here’s a detailed guide on enabling and extending folding with nvim-ufo in Neovim.

```lua
-- nvim/lua/scratch/custom/editor.lua

return {
    { "kevinhwang91/nvim-ufo", enabled = true },
}
```
