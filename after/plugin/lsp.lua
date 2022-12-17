local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.nvim_workspace()

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
    'sumneko_lua',
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local bind = vim.keymap.set

    bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    bind('n', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', opts)
    bind('n', '<leader>bf', '<cmd>LspZeroFormat<cr>', opts)
    bind('v', '<leader>f', '<cmd>LspZeroFormat<cr>', opts)
    bind('n', '<space>tl', function()
        require('lsp_lines').toggle()
        vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
    end, { buffer = opts.buffer, remap = opts.remap, desc = "Toggle lsp lines" } )
end)


local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.setup()

-- Initialize rust_analyzer with rust-tools
require('rust-tools').setup({server = rust_lsp})

vim.diagnostic.config({
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    virtual_text = true,
    virtual_lines = false,
})
