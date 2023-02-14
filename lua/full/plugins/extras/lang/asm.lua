return {

  -- correctly setup mason lsp / debug extensions
  -- {
  --   "williamboman/mason.nvim",
  --   ft = "lua",
  --   module = true,
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "stylua",
  --       "lua-language-server",
  --     })
  --   end,
  -- },

  --- lsp
  {
    "neovim/nvim-lspconfig",
    ft = "asm",
    module = true,
    dependencies = { "mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      servers = {
        asm_lsp = {},
      },
    },
  },
}
