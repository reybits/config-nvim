return {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = {
        "BufReadPost",
        "BufNewFile",
    },
    dependencies = {
        "kevinhwang91/promise-async",
    },
    config = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        -- vim.o.foldenable = true
        -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        ---@diagnostic disable-next-line: missing-fields
        require("ufo").setup({
            -- Note: the `nvim-treesitter` plugin is *not* needed.
            -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
            -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
            provider_selector = function(_, _, _) -- (bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,

            -- Adding number suffix of folded lines instead of the default ellipsis
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰇘  %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,
        })
    end,
}
