return {
  -- Debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<F5>",  function() require("dap").continue() end,          desc = "Continue", },
      { "<F9>",  function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "<F11>", function() require("dap").step_into() end,         desc = "Step Into", },
      { "<F10>", function() require("dap").step_over() end,         desc = "Step Over", },
    },
  },

  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>dwa", function() require("dapui").elements.watches.add() end, desc = "Watch Add", },
      { "<leader>dwd",  function() require("dapui").elements.watches.remove() end, desc = "Watch Remove", },
      -- { "<leader>dwe", function() require("dapui").elements.watches.edit() end, desc = "Watch Edit", },
      { "<leader>dwr", function() require("dapui").elements.watches.repl() end, desc = "Watch REPL", },
    },
    opts = {
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>", "<tab>" },
      },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>dw"] = { name = "+watches" },
      },
    },
  },
}
