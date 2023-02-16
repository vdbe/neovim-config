return {

  {
    "neovim/nvim-lspconfig",
    ft = "dockerfile",
    module = true,
    dependencies = { "mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      servers = {
        dockerls = {},
      },
    },
  },
}
