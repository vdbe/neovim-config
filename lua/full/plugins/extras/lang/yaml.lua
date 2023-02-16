return {
  -- add yaml to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml" })
      end
    end,
  },

  -- correctly setup mason lsp
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "yaml-language-server" })
    end,
  },

  --- lsp
  {
    "neovim/nvim-lspconfig",
    ft = "yaml",
    module = true,
    dependencies = { "mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      yaml = {
        --schemaStore = {
        --  url = "https://www.schemastore.org/api/json/catalog.json",
        --  enable = true,
        --},
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
      },
    },
  },
}
