return {
    "JafarDakhan/vim-gml",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.filetype.add({
            extension = {
                yy = "json",
                yyp = "json",
            },
        })
    end,
}
