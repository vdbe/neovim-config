return {
  {
    "neovim/nvim-lspconfig",
    ft = "nix",
    module = true,
    dependencies = { "mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      servers = {
        rnix = {},
      },
    },
  },
}
