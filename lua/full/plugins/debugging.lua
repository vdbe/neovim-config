return {

  -- dap
  {
    "mfussenegger/nvim-dap",
    module = true,
    lazy = true,
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
      "nvim-telescope/telescope-dap.nvim",
      {
        "rcarriga/nvim-dap-ui",
        config = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dbl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message")) end, desc = "logpoint" },
      { "<leader>dbr", function() require("dap.breakpoints").clear() end, desc = "remove all" },
      { "<leader>dbs", "<CMD>Telescope dap list_breakpoints<CR>", desc = "show all" },
      { "<leader>dbt", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "continue" },
      { "<F5>", function() require("dap").continue() end, desc = "continue" },
      { "<leader>de", function() require("dap.ui.widgets").hover(nil, { border = "none" }) end, desc = "expression", mode = { "n", "v" } },
      { "<leader>dp", function() require("dap").pause() end, desc = "pause" },
      { "<leader>dr", "<CMD>Telescope dap configurations<CR>", desc = "run" },
      { "<leader>dsb", function() require("dap").step_back() end, desc = "step back" },
      { "<leader>dsc", function() require("dap").run_to_cursor() end, desc = "step to cursor" },
      { "<leader>dsi", function() require("dap").step_into() end, desc = "step into" },
      { "<F11>", function() require("dap").step_into() end, desc = "step into" },
      { "<leader>dso", function() require("dap").step_over() end, desc = "step over" },
      { "<F10>", function() require("dap").step_over() end, desc = "step over" },
      { "<leader>dsx", function() require("dap").step_out() end, desc = "step out" },
      { "<F12>", function() require("dap").step_out() end, desc = "step out" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "terminate" },
      { "<leader>dvu", function() require("dapui").open() end, desc = "open dapui" },
      { "<leader>dvf", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames, { border = "none" }) end,
        desc = "show frames" },
      { "<leader>dvr", function() require("dap").repl.open(nil, "20split") end, desc = "show repl" },
      { "<leader>dvs", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, { border = "none" }) end,
        desc = "show scopes" },
      { "<leader>dvt", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads, { border = "none" }) end,
        desc = "show threads" },
    },
    -- stylua: ignore
    config = function()
      local icons = require("full.config").icons.debugging
      vim.fn.sign_define("DapBreakpoint", { text = icons.BreakPoint, texthl = "SignColumn", linehl = "", numhl = "" })
      vim.fn.sign_define( "DapBreakpointCondition", { text = icons.BreakPointCondition, texthl = "SignColumn", linehl = "", numhl = "" })
      vim.fn.sign_define( "DapBreakpointRejected", { text = icons.BreakPointRejected, texthl = "SignColumn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = icons.LogPoint, texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = icons.Stopped, texthl = "", linehl = "", numhl = "" })

      local dap, dapui = require("dap"), require("dapui")
      dap.defaults.fallback.terminal_win_cmd = "enew"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          require("dap.ext.autocompl").attach()
        end,
      })

      --dap.listeners.after.event_initialized["dapui_config"] = function()
      --  dapui.open()
      --end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      require("which-key").register({
        ["<leader>db"] = { name = "+breakpoints" },
        ["<leader>ds"] = { name = "+steps" },
        ["<leader>dv"] = { name = "+views" },
      })
    end,
  },
}
