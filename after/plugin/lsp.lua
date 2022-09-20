vim.keymap.set({'i'}, '<C-a>', '<cmd>CodeActionMenu<cr>', {
    desc = 'Code action menu',
    noremap = true, silent = true
})
vim.keymap.set({'n', 'v'}, '<leader>ca', '<cmd>CodeActionMenu<cr>', {
    desc = 'Code action menu',
    noremap = true, silent = true
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

require("mason").setup {}
require("mason-lspconfig").setup {}
require('nvim-lightbulb').setup({autocmd = {enabled = true}})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- update when in insert
vim.diagnostic.config({
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    virtual_lines = false,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- TODO: Add desc
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wl', function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  vim.keymap.set('n', '<space>tl', function()
        require('lsp_lines').toggle()
        vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
    end,
    bufopts)
end
local lsp_flags = { }

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
        on_attach = on_attach,
        flags = lsp_flags,
    }, _config or {})
end


local lspconfig = require("lspconfig");


lspconfig.pyright.setup(config())
lspconfig.tsserver.setup(config())
--lspconfig.rust_analyzer.setup(config())
lspconfig.gopls.setup(config())
lspconfig.html.setup(config())
lspconfig.cssls.setup(config())
lspconfig.tailwindcss.setup(config())
lspconfig.bashls.setup(config())
lspconfig.emmet_ls.setup(config({
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
}))
lspconfig.sumneko_lua.setup(config({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}))


local rustopts = {
    tools = {
      autoSetHints = true,
      hover_with_actions = false,
      inlay_hints = {
        only_current_line = false,
      }
    },
    server = {
      standalone = false;
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
      on_attach = on_attach,
      flags = lsp_flags
    }
}
require('rust-tools').setup(rustopts)
