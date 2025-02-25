# Nvim from Scratch

[![Plugins](https://dotfyle.com/andreyugolnik/config-nvim-nvim/badges/plugins?style=flat)](https://dotfyle.com/andreyugolnik/config-nvim-nvim)
[![leaderkey](https://dotfyle.com/andreyugolnik/config-nvim-nvim/badges/leaderkey?style=flat)](https://dotfyle.com/andreyugolnik/config-nvim-nvim)
[![plugin-manager](https://dotfyle.com/andreyugolnik/config-nvim-nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/andreyugolnik/config-nvim-nvim)

This repository contains my custom Neovim configuration for Linux, macOS, and potentially Windows. The setup is built from scratch and includes only the plugins I actively use in my workflow. I primarily use Neovim as a C++ IDE for cross-platform game development.

For the best experience, use it alongside my [config-tmux](https://github.com/andreyugolnik/config-tmux.git) repository.

![Nvim wiht Lazy](https://github.com/andreyugolnik/config-nvim/blob/master/nvim-lazy.png?raw=true)

## Install

```sh
git clone https://github.com/andreyugolnik/config-nvim.git ~/.config/nvim
```

## Features

- Plugin management via Lazy.nvim.
- Tool manager via Mason.nvim.
- Startup screen via dashboard-nvim.
- Colorscheme via nightfox.nvim.
- Nice statusline via lualine.nvim.
- Language server protocol (LSP) support via nvim-lspconfig.
- Code auto-completion via nvim-cmp.
- Fast navigation, lookup, and more via telescope.nvim with fzf.
- Buffer bookmarks via harpoon2.
- Git integration via neogit or vim-fugitive.
- Code commenting via Comment.nvim.
- File tree explorer via nvim-tree.lua.
- Mapping hint via which-key.nvim.
- Code highlighting via nvim-treesitter.
- Markdown writing and previewing via vim-markdown and markdown-preview.nvim.
- And more...

## Customize

To customize plugins, enable, or disable integration with other tools, inside the `nvim/lua/scratch/custom` directory, create a `plugin-name.lua` file with the plugin name and add custom settings.

### Git related

By default, Neogit is used as the Git plugin. However, you can change this by creating a `git.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/git.lua

return {
    -- disable neogit
    { "NeogitOrg/neogit", enabled = false },

    -- enable vim-fugitive and it's companion
    { "tpope/vim-fugitive",enabled = true },
    { "tpope/vim-rhubarb",enabled = true },
    { "rbong/vim-flog",enabled = true },
}
```

### AI related

By default, both Copilot and Codeium plugins are disabled. To enable them, create an `AI.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/AI.lua

return {
    -- enable Copilot
    { "github/copilot.vim", enabled = true },

    -- or enable Codeium
    { "Exafunction/codeium.nvim", enabled = true },
}
```

