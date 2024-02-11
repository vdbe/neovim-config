return {
  -- Can't disable mason because some modules in plugins in
  -- "lazy.plugins.extras" call `require("mason-registry")`
  -- { "williamboman/mason.nvim", enabled = false },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = {
      PATH = "append",
      -- registries = {}, -- Best option to "disable" mason.nvim
    },
  },
  -- { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  -- { "williamboman/mason-lspconfig.nvim", enabled = false },
}
