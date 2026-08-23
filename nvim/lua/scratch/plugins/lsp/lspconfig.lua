return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason should be loaded before lspconfig to ensure LSP servers are installed.
        "mason-org/mason.nvim",

        -- I assume that vim.notify handler is set before nvim-lspconfig is loaded.
        "j-hui/fidget.nvim",
    },
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        --
        -- Disable LSP logging. Neovim's RPC layer logs all LSP server stderr
        -- output (e.g., clangd info messages) as ERROR, causing the log file
        -- (~/.local/state/nvim/lsp.log) to grow unboundedly. Real LSP issues
        -- are still surfaced via vim.notify and diagnostics.
        --
        if vim.lsp.log ~= nil then
            vim.lsp.log.set_level(vim.log.levels.OFF)
        else
            -- TODO: Remove else part once Neovim 0.12+ is released.
            ---@diagnostic disable-next-line: deprecated
            vim.lsp.set_log_level(vim.log.levels.OFF)
        end

        --
        -- Set up custom diagnostic signs using icons from scratch.core.helpers.
        --
        local helpers = require("scratch.core.helpers")
        local signs = { text = {} }
        for type, icon in pairs(helpers.icons.diagnostics) do
            local key = string.upper(type)
            signs.text[vim.diagnostic.severity[key]] = icon
        end
        vim.diagnostic.config({
            signs = signs,
        })

        --
        -- Configure Lua Language Server for Neovim development
        -- Special Lua Config, as recommended by neovim help docs
        --
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (
                            vim.uv.fs_stat(path .. "/.luarc.json")
                            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                        )
                    then
                        return
                    end
                end

                client.config.settings.Lua =
                    vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                            path = { "lua/?.lua", "lua/?/init.lua" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- This is a lot slower and will cause issues when working on your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    })
            end,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        vim.lsp.config("clangd", {
            cmd = { "clangd", "--offset-encoding=utf-16" },
        })

        vim.lsp.config("copilot", {
            cmd = { "copilot-language-server", "--stdio" },
            root_markers = { ".git" },
            settings = {
                telemetry = {
                    telemetryLevel = "off",
                },
            },
        })

        --
        -- Enable specific LSP servers.
        -- LSP servers installed via mason.nvim and configured via lspconfig.
        --
        vim.lsp.enable({
            "clangd",
            "copilot",
            -- "groovyls",
            "jdtls",
            "jsonls",
            -- "kotlin_language_server",
            "lua_ls",
            "neocmake",
            "quick_lint_js",
        })

        -- TODO: Remove once Neovim 0.12+ is released.
        if vim.lsp.inline_completion == nil then
            local msg = "Inline Completion is not supported."
            vim.notify(msg, vim.log.levels.WARN)
            vim.print(msg .. " Update to Neovim 0.12+ to use this feature.")
        end

        local _blink_autocmds_created = false
        local _inline_was_enabled = true

        --
        -- Function to run when the LSP server attaches to a buffer.
        --
        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc, mode)
                mode = mode or "n"
                vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, silent = true })
            end

            local ToggleOption = require("scratch.core.toggleopt")

            -- Instead of "stevearc/conform.nvim" plugin
            --[[
            if client.server_capabilities.documentFormattingProvider then
                ToggleOption.new({
                    map = "<leader>oef",
                    title = "Autoformat",
                    buffer = bufnr,
                    silent = true,
                    get = function()
                        return vim.g.autoformat_toggle ~= false
                    end,
                    set = function(state)
                        vim.g.autoformat_toggle = state
                    end,
                })

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("lsp-buffer-format", { clear = false }),
                    callback = function()
                        if vim.g.autoformat_toggle ~= false then
                            vim.lsp.buf.format({ async = false })
                        end
                    end,
                })

                map("<leader>bf", function()
                    vim.lsp.buf.format({ async = false })
                end, "Buffer Format")
            end
            --]]

            -- Inline Completion. Requires nvim 0.12 and above.
            -- Key mappings:
            -- <Tab>   - Accept the current suggestion.
            -- <m-]>   - Cycle to the next suggestion.
            -- <m-[>   - Cycle to the previous suggestion.
            -- <m-l>   - Accept the next word of the current suggestion.
            -- <m-j>   - Accept the next line of the current suggestion.
            -- <C-e>   - Dismiss the current suggestion.
            if client.name == "copilot" and vim.lsp.inline_completion ~= nil then
                -- Enable inline completion globally by default.
                vim.lsp.inline_completion.enable(true)

                -- Coordinate with blink-cmp: suppress inline completions
                -- while the completion menu is open.
                if not _blink_autocmds_created then
                    _blink_autocmds_created = true
                    local blink_group = vim.api.nvim_create_augroup("scratch_inline_blink", { clear = true })

                    vim.api.nvim_create_autocmd("User", {
                        group = blink_group,
                        pattern = "BlinkCmpMenuOpen",
                        callback = function()
                            _inline_was_enabled = vim.lsp.inline_completion.is_enabled()
                            vim.lsp.inline_completion.enable(false)
                        end,
                    })

                    vim.api.nvim_create_autocmd("User", {
                        group = blink_group,
                        pattern = "BlinkCmpMenuClose",
                        callback = function()
                            vim.lsp.inline_completion.enable(_inline_was_enabled)
                        end,
                    })
                end

                -- Feed `delta` as typed so `.` in normal mode replays it.
                -- For multi-line text the raw \n between lines would trigger
                -- autoindent on Enter and shift the suggestion's own leading
                -- whitespace; <CR><C-u> clears the auto-inserted indent so
                -- what actually gets typed matches the suggestion byte-for-byte.
                local cr_ctrlu = vim.api.nvim_replace_termcodes("<CR><C-u>", true, false, true)
                local function feed_delta(delta)
                    if not delta:find("\n", 1, true) then
                        vim.api.nvim_feedkeys(delta, "nt", false)
                        return
                    end
                    local lines = vim.split(delta, "\n", { plain = true })
                    local parts = { lines[1] }
                    for i = 2, #lines do
                        parts[#parts + 1] = cr_ctrlu
                        parts[#parts + 1] = lines[i]
                    end
                    vim.api.nvim_feedkeys(table.concat(parts), "nt", false)
                end

                -- Build the opts for inline_completion.get() that skip the
                -- built-in nvim_buf_set_text and instead feedkeys the delta,
                -- so `.` in normal mode replays the whole accepted change.
                -- `truncate`, if given, trims the delta to a word or line for
                -- partial accepts.
                local function accept(truncate)
                    return {
                        on_accept = function(item)
                            if type(item.insert_text) ~= "string" then
                                return item -- snippet: fall back to built-in
                            end
                            local text = item.insert_text
                            local delta = text
                            if item.range then
                                local sr, sc, er, ec = item.range:to_extmark()
                                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                                if sr == row - 1 and er == row - 1 and ec == col then
                                    delta = text:sub(math.max(0, col - sc) + 1)
                                else
                                    return item -- unusual range: keep built-in
                                end
                            end
                            if truncate then
                                delta = truncate(delta) or ""
                            end
                            if delta == "" then
                                return nil
                            end
                            feed_delta(delta)
                            if item.command then
                                local client = vim.lsp.get_client_by_id(item.client_id)
                                if client then
                                    client:exec_cmd(item.command, { bufnr = 0 })
                                end
                            end
                            return nil
                        end,
                    }
                end

                vim.keymap.set("i", "<Tab>", function()
                    if not vim.lsp.inline_completion.get(accept()) then
                        return "<Tab>"
                    end
                end, { buffer = bufnr, expr = true, desc = "Accept inline completion" })

                vim.keymap.set("i", "<m-]>", function()
                    vim.lsp.inline_completion.select()
                end, { buffer = bufnr, desc = "Next inline completion" })

                vim.keymap.set("i", "<m-[>", function()
                    vim.lsp.inline_completion.select({ count = -1 })
                end, { buffer = bufnr, desc = "Previous inline completion" })

                vim.keymap.set("i", "<C-e>", function()
                    if not vim.lsp.inline_completion.get({ on_accept = function() end }) then
                        return "<C-e>"
                    end
                end, { buffer = bufnr, expr = true, desc = "Dismiss inline completion" })

                vim.keymap.set("i", "<m-l>", function()
                    vim.lsp.inline_completion.get(accept(function(delta)
                        -- First word beyond the ghost-text boundary, with any
                        -- leading whitespace; fall back to the whole delta so
                        -- <m-l> at end-of-suggestion behaves like a full accept.
                        return delta:match("^(%s*%S+)") or delta
                    end))
                end, { buffer = bufnr, desc = "Accept word of inline completion" })

                vim.keymap.set("i", "<m-j>", function()
                    vim.lsp.inline_completion.get(accept(function(delta)
                        return delta:match("^([^\n]*\n?)")
                    end))
                end, { buffer = bufnr, desc = "Accept line of inline completion" })

                ToggleOption.new({
                    map = "<leader>oi",
                    title = "Inline Completion",
                    buffer = bufnr,
                    silent = true,
                    get = function()
                        return vim.lsp.inline_completion.is_enabled()
                    end,
                    set = function(state)
                        vim.lsp.inline_completion.enable(state)
                    end,
                })
            end

            -- Switch Source/Header for C/C++ (clangd extension)
            if client.name == "clangd" then
                map("gs", function()
                    local buf = vim.api.nvim_get_current_buf()
                    local clangd = vim.lsp.get_clients({ bufnr = buf, name = "clangd" })[1]
                    if not clangd then
                        vim.notify("clangd is not attached", vim.log.levels.WARN)
                        return
                    end

                    -- clangd expects TextDocumentIdentifier (uri at root)
                    local params = { uri = vim.uri_from_bufnr(buf) }
                    ---@diagnostic disable-next-line: param-type-mismatch
                    clangd:request("textDocument/switchSourceHeader", params, function(err, result)
                        if err then
                            vim.notify("switchSourceHeader: " .. err.message, vim.log.levels.WARN)
                            return
                        end

                        if not result or result == "" then
                            vim.notify("No matching header/source file found", vim.log.levels.WARN)
                            return
                        end

                        local target = type(result) == "table" and result[1] or result
                        if target then
                            vim.cmd("edit " .. vim.uri_to_fname(target))
                        end
                    end, buf)
                end, "Switch Source/Header")
            end

            if client.server_capabilities.declarationProvider then
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")
            end

            if client.server_capabilities.definitionProvider then
                map("gd", vim.lsp.buf.definition, "Goto Definition")
            end

            if client.server_capabilities.implementationProvider then
                map("gi", vim.lsp.buf.implementation, "Goto Implementation")
            end

            -- if client.server_capabilities.typeDefinitionProvider then
            --     map("<leader>cd", vim.lsp.buf.type_definition, "Goto Type Definition")
            -- end

            if client.server_capabilities.hoverProvider then
                map("K", function()
                    return vim.lsp.buf.hover({
                        border = "rounded",
                        title = "Symbol Info",
                    })
                end, "Symbol Info")
            end

            if client.server_capabilities.signatureHelpProvider then
                map("<leader>ck", function()
                    return vim.lsp.buf.signature_help({
                        border = "rounded",
                        title = "Signature Info",
                    })
                end, "Signature Info")
            end

            -- Instead of use Trouble/Telescope/Fzf-lua
            -- if client.server_capabilities.referencesProvider then
            --     map("<leader>sr", vim.lsp.buf.references, "Referencies List")
            -- end

            if client.server_capabilities.renameProvider then
                map("<leader>cR", vim.lsp.buf.rename, "Rename Referencies")
            end

            if client.server_capabilities.codeActionProvider then
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
            end

            -- Show diagnostics in the floating window.
            -- TODO: Investigate which server capability requires this.
            -- if client.server_capabilities.diagnosticProvider then
            map("<leader>cf", function()
                local float_opts = { scope = "line", border = "rounded" }
                local float_bufnr, _ = vim.diagnostic.open_float(float_opts)
                if float_bufnr == nil then
                    vim.notify("No diagnostics found")
                end
            end, "Line Diagnostics")
            -- end

            if client.server_capabilities.inlayHintProvider then
                ToggleOption.new({
                    map = "<leader>coh",
                    title = "Inline Hint",
                    buffer = bufnr,
                    silent = true,
                    get = function()
                        return vim.lsp.inlay_hint.is_enabled({})
                    end,
                    set = function(state)
                        vim.lsp.inlay_hint.enable(state)
                    end,
                })
            end

            -- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
            -- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")

            -- map("<leader>wl", function()
            --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, "List Workspace Folders")
        end

        --
        -- Attach the on_attach function to LSP clients when they connect.
        --
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("scratch_lsp_attach", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end

                -- vim.print(
                --     "Attach: "
                --         .. client.name
                --         .. ", with cpabilities:\n"
                --         .. vim.inspect(client.server_capabilities)
                -- )

                on_attach(client, args.buf)
            end,
        })
    end,
}
