# Nvim from Scratch

[![Plugins](https://dotfyle.com/reybits/config-nvim-nvim/badges/plugins?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)
[![leaderkey](https://dotfyle.com/reybits/config-nvim-nvim/badges/leaderkey?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)
[![plugin-manager](https://dotfyle.com/reybits/config-nvim-nvim/badges/plugin-manager?style=flat)](https://dotfyle.com/reybits/config-nvim-nvim)

This repository contains my custom Neovim configuration for Linux, macOS, and potentially Windows. The setup is built from scratch and includes only the plugins I actively use in my workflow. I primarily use Neovim as a C++ IDE for cross-platform game development.

For the best experience, use it alongside my [config-tmux](https://github.com/reybits/config-tmux.git) repository.

![blink-cmp](https://private-user-images.githubusercontent.com/1927370/423180406-1d7be7dc-d8b4-4207-8f87-2e33c22b9e36.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDIwOTMyMTAsIm5iZiI6MTc0MjA5MjkxMCwicGF0aCI6Ii8xOTI3MzcwLzQyMzE4MDQwNi0xZDdiZTdkYy1kOGI0LTQyMDctOGY4Ny0yZTMzYzIyYjllMzYucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDMxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTAzMTZUMDI0MTUwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9MDgwZmQxN2I3YjE0ZTJjYjYzYTU3YmE2MTM2YmVjMmFhOTg3YWEzYmNkYWZlNTdlM2ZlN2JiN2MyODBmNmVjNyZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.RxLBfqZA2EewZJgme6Ogc_akcnyXGG9G4QyP1RwC3E8)

## Install

```sh
git clone https://github.com/reybits/config-nvim.git ~/.config/nvim
```

### Dependencies

- [fzf](https://github.com/junegunn/fzf): a command-line fuzzy finder.
- [viu](https://github.com/atanunq/viu): a terminal image viewer with native support for iTerm and Kitty.
- [fd](https://github.com/sharkdp/fd): a better version of the find utility.
- [ripgrep(rg)](https://github.com/BurntSushi/ripgrep): a better version of the grep utility.

## Features

### Enabled by default

- Plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim.git).
- Tool manager via [mason.nvim](https://github.com/williamboman/mason.nvim).
- Startup screen via [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim).
- Sessions support via [mini.sessions](https://github.com/echasnovski/mini.sessions).
- Colorscheme via [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim).
- Mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvi).
- Git integration via [neogit](https://github.com/NeogitOrg/neogit), [vim-fugitive](https://github.com/tpope/vim-fugitive), [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), and [gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim).
- File tree explorer via [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua).
- Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- Code auto-completion via [blink-cmp](https://github.com/Saghen/blink.cmp).
- Code debugging via [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) and [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
- Code commenting via [ts-comments.nvim](https://github.com/folke/ts-comments.nvim).
- Code formatting via [conform.nvim](https://github.com/stevearc/conform.nvim).
- Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- TMUX support via [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator).
- Improved quickfix UI via [quicker.nvim](https://github.com/stevearc/quicker.nvim).
- Fast navigation, lookup, and more via [fzf-lua](https://github.com/ibhagwan/fzf-lua).
- Buffer navigation via [flush.nvim](https://github.com/folke/flush.nvim).
- Bookmarks via [harpoon](https://github.com/ThePrimeagen/harpoon) v2.
- Undo tree explorer via [undotree](https://github.com/mbbill/undotree).
- Markdown writing and previewing via [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
- Hide passwords/keys via [cloak.nvim](https://github.com/laytan/cloak.nvim).
- Blind typing trainer via [typr](https://github.com/nvzone/typr).
- And more...

### Optional

- Telescope [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- LazyGit [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim).
- Octo [octo.nvim](https://github.com/pwntester/octo.nvim).
- Codeium [neocodeium](https://github.com/monkoose/neocodeium).
- Colorscheme Nightfox [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim).
- Folding nvim-ufo [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo).

## Customize

To customize plugins, enable, or disable integration with other tools, inside the `nvim/lua/scratch/custom` directory, create a `plugin-name.lua` file with the plugin name and add custom settings.

### Navigation related

![fzf-lua](https://private-user-images.githubusercontent.com/1927370/423180411-b075a508-b0d1-4fc4-b3ee-2686fb94d756.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDIwOTMyMTAsIm5iZiI6MTc0MjA5MjkxMCwicGF0aCI6Ii8xOTI3MzcwLzQyMzE4MDQxMS1iMDc1YTUwOC1iMGQxLTRmYzQtYjNlZS0yNjg2ZmI5NGQ3NTYucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDMxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTAzMTZUMDI0MTUwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YThjNDgyZmQwZjBhNzU3YTA3YTZiYmRjODM2MmQ0NjE0YWQwMTk3MTc5OTU1MWRhMmU0NjIyZTgxNTBlOTU0NCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.QVwGyXOa4Z1YE_Idy6RcQj6aa3gqWuIcucOffZGc4QI)

By default, fzf-lua is used as the navigation plugin, you can change this by creating a `telescope.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/telescope.lua

return {
    -- Use telescope instead of fzf-lua
    require("scratch.custom.optional.telescope")
    { "ibhagwan/fzf-lua", enabled = false },
```

### Git related

![neogit](https://private-user-images.githubusercontent.com/1927370/423180408-b1860e9e-d4f0-44ff-96d7-57687dcf3c54.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDIwOTMyMTAsIm5iZiI6MTc0MjA5MjkxMCwicGF0aCI6Ii8xOTI3MzcwLzQyMzE4MDQwOC1iMTg2MGU5ZS1kNGYwLTQ0ZmYtOTZkNy01NzY4N2RjZjNjNTQucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDMxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTAzMTZUMDI0MTUwWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9OGRhYTI3MzY5OGVjNDgwMWIxZTkwODRiNDYyNzljMzM0NGEzNzNlNzk0N2FkYWM2Njg1MGNhYWRiOGVkNDE0NyZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.2-RHIaPnxXK6j7xrtk61o4W5lv6RD8QvGiDjeVMqC0k)

By default, Neogit and vim-fugitive is used as the Git plugin.

#### LazyGit as main git plugin

You can use LazyGit as main git plugin by creating a `lazygit.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/lazygit.lua

return {
    -- Use LazyGit instead of Neogit and vim-fugitive
    require("scratch.custom.optional.lazygit"),
    { "NeogitOrg/neogit", enabled = false },
    { "tpope/vim-fugitive", enabled = false },
```

#### Fugitive as main git plugin

You can use Fugitive as main git plugin by creating a `fugitive.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/fugitive.lua

return {
    -- Use vim-fugitive and its companions instead of Neogit
    require("scratch.custom.optional.vim-rhubarb")
    require("scratch.custom.optional.vim-flog")
    { "NeogitOrg/neogit", enabled = false },
}
```

#### Octo as GitHub companion

You can add support for the Octo plugin to work with GitHub by creating a `octo.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/octo.lua

return {
    require("scratch.custom.optional.octo")
}
```

### AI related

#### Copilot

![copilot chat](https://private-user-images.githubusercontent.com/1927370/423180412-bbfb6ab6-2f88-4ffe-a7a1-8cd8a39a42a5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDIwOTM0NTksIm5iZiI6MTc0MjA5MzE1OSwicGF0aCI6Ii8xOTI3MzcwLzQyMzE4MDQxMi1iYmZiNmFiNi0yZjg4LTRmZmUtYTdhMS04Y2Q4YTM5YTQyYTUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI1MDMxNiUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNTAzMTZUMDI0NTU5WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YjI4MGEzMjViZmVlNjdlMTgwNTJkZTRiZTdlMzAwN2E4MWMxMTBlZTEzODAxZTU4Y2U4MDY1NzU4MTA2ZmJlZiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.xByWApW7lIog-mBYKkDH0OdXBhhJMQcyI8hmiyTTPJM)

Both Copilot and CopilotChat plugins are enabled by defautl. Copilot integrated into the completion menu via blink-cmp.

You can disable Copilot by creating a `copilot.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/copilot.lua

return {
    -- Disable Copilot and Copilot Chat
    { "github/copilot.vim", enabled = false },
    { "CopilotC-Nvim/CopilotChat.nvim", enabled = false },
```

#### Codeium

Codeium is disabled by default. However, you can enable it by creating a `codeium.lua` file with the following content:

```lua
-- nvim/lua/scratch/custom/codeium.lua

return {
    -- Enable Codeium without the completion menu support,
    -- use mappings instead:
    -- <tab> to accept suggestion
    -- <a-e> to cycle through suggestions
    require("scratch.custom.optional.neocodeium"),
}
```

### Editor related

#### Folding via UFO

Here’s a detailed guide on enabling and extending folding with nvim-ufo in Neovim.

```lua
-- nvim/lua/scratch/custom/editor.lua

return {
    -- Enable nvim-ufo
    require("scratch.custom.optional.nvim-ufo"),
}
```

## Useful links

- [fzf-lua wiki](https://github.com/ibhagwan/fzf-lua/wiki).
