local lsp = require('lsp-zero')
local cmp = require('cmp')

lsp.preset('recommended')
lsp.set_preferences({
  set_lsp_keymaps = {
    omit = {
      'gr',
      '<F4>',
    }
  },
})

lsp.nvim_workspace()

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
  'sumneko_lua',
})

local cmp_sources = lsp.defaults.cmp_sources()
local cmp_config = lsp.defaults.cmp_config({

})

table.insert(cmp_sources, {})

lsp.setup_nvim_cmp({
  sources = cmp_sources
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local bind = vim.keymap.set

  bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  bind('n', '<leader>a', '<cmd>CodeActionMenu<cr>', opts)
  bind('n', '<leader>bf', '<cmd>LspZeroFormat<cr>', opts)
  bind('v', '<leader>f', '<cmd>LspZeroFormat<cr>', opts)

  bind("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true, desc = "Toggle trouble diagnostics" }
  )
  bind("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true, desc = "Toggle trouble workspace diagnostics" }
  )
  bind("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true, desc = "Toggle trouble document diagnostics" }
  )
  bind("n", "<leader>xt", "<cmd>TroubleToggle lsp_type_definitions<cr>",
    { silent = true, noremap = true, desc = "Toggle trouble type definitions" }
  )
  bind("n", "gr", "<cmd>TroubleToggle lsp_references<cr>",
    { remap = true, desc = "Toggle trouble lsp references" }
  )

  bind('i', '<C-k>', vim.lsp.buf.signature_help, opts)


  bind('n', '<space>tl', function()
    require('lsp_lines').toggle()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  end, { buffer = opts.buffer, remap = opts.remap, desc = "Toggle lsp lines" })
end)


local rust_lsp = lsp.build_options('rust_analyzer', {})

-- Initialize rust_analyzer with rust-tools
require('rust-tools').setup({ server = rust_lsp })

lsp.setup()

cmp.setup(cmp_config)

cmp.setup.cmdline('/', {
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
})


cmp.setup.cmdline(':', {
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
})

vim.diagnostic.config({
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  signs = true,
  virtual_text = true,
  virtual_lines = false,
})
