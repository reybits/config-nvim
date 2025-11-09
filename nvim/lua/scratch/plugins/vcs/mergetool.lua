-- If you get "Conflict markers miss common base revision" error message,
-- put the following in your ~/.gitconfig to use diff3 conflict style as a default:
--
-- ```gitconfig
-- [merge]
--     conflictStyle = diff3
-- ```
--
-- If something goes absolutely wrong, you can always reset conflict markers in
-- a file to their initial state. It's safe to do it only during ongoing merge,
-- otherwise you'd overwrite file in a working tree with version from index.
--
-- ```bash
-- git checkout --conflict=diff3 {file}
-- ```
--
-- Source: https://github.com/samoshkin/vim-mergetool

return {
    "samoshkin/vim-mergetool",
    keys = {
        { "<leader>gmm", "<cmd>MergetoolToggle<cr>", desc = "Toggle Mergetool" },
        { "<leader>gmn", "<cmd>MergetoolNextConflict<cr>", desc = "Next Conflict" },
        { "<leader>gmp", "<cmd>MergetoolPrevConflict<cr>", desc = "Previous Conflict" },
    },
    init = function()
        -- In case of rebase branch FEATURE onto branch MASTER:
        -- B is the common ancestor of branches FEATURE and MASTER (base)
        -- R is the version from branch FEATURE (remote)
        -- L is the version from branch MASTER (local)
        -- M is the version that git has auto-merged (if possible)
        -- vim.g.mergetool_layout = "BR,M"
        vim.g.mergetool_layout = "LBR,M"
    end,
}
