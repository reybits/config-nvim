return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local comment = require("Comment")
        comment.setup({})

        -- fix commentstring for objective-c types
        local ft = require("Comment.ft")
        ft.set("objc", { "// %s", "/* %s */" })
    end,
}
