return {
  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    enabled = false, -- Use mini.notify instead
    optional = true,
    opts = {
      render = "minimal",
      stages = "static",
      top_down = false,
    },
  },
  {
    "echasnovski/mini.notify",
    event = "VeryLazy",
    lazy = true,
    version = false,
    keys = {
      {
        "<leader>un",
        function()
          require("MiniNotify").clear({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      window = {
        config = function()
          local has_statusline = vim.o.laststatus > 0
          local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
          return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - bottom_space }
        end,
      },
    },
    config = function(_, opts)
      require("mini.notify").setup(opts)

      vim.notify = require("mini.notify").make_notify()

      vim.api.nvim_create_user_command("Notifications", function()
        require("mini.notify").show_history()
      end, {})
    end,
  },
}
