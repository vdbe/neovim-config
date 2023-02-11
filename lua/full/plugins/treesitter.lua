return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Schrink selection", mode = "x" },
  },
  ---@type TSConfig
  opts = {
    ensure_installed = { "bash" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = { enable = true },
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
