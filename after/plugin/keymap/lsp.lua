local nnoremap = require("nobody.keymap").nnoremap

nnoremap("<leader>e", vim.diagnostic.open_float)
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<leader>q", vim.diagnostic.setloclist)
