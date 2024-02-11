return {
  -- Add nasm to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "nasm" })
      end
    end,
  },

  -- Enable lsp
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        asm_lsp = {},
      },
    },
  },

  -- Ensure asm tools are installed
  -- {
  --   "williamboman/mason.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "asmfmt" })
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.formatting.asmfmt,
  --     })
  --   end,
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       asm = { "asmfmt" },
  --     },
  --   },
  -- },
}
