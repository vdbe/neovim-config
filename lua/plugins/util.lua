return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>cg"] = { name = "+Generate Doc" },
      },
    },
  },

  {
    "danymat/neogen",
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    lazy = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- stylua: ignore
    keys = {
      { "<leader>cgf", function()  require("neogen").generate({ type = "func" }) end, desc = "Function", },
      { "<leader>cgm", function()  require("neogen").generate({ type = "function" }) end, desc = "Method", },
      { "<leader>cgc", function()  require("neogen").generate({ type = "class" }) end, desc = "Class", },
      { "<leader>cgt", function()  require("neogen").generate({ type = "type" }) end, desc = "Type", },
      { "<leader>cgF", function()  require("neogen").generate({ type = "file" }) end, desc = "file", },
    },
    opts = {
      snippet_engine = "luasnip",
    },
    config = true,
  },
}
