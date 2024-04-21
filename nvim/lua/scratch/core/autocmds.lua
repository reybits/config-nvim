--- enable cursor line for current buffer only ---------------------------------
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    pattern = { "*" },
    command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
    pattern = { "*" },
    command = "setlocal nocursorline",
})
--[[
--- and disable it for .xml ----------------------------------------------------
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    pattern = { "*.xml" },
    command = "setlocal nocursorline",
})
--]]

--- restore cursor position ----------------------------------------------------
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  desc = "return cursor to where it was last time closing the file",
  pattern = { "*" },
  command = 'silent! normal! g`"zv',
})
