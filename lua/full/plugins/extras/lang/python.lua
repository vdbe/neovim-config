return {
  -- TODO: Lazy load formatters/treesitter/mason

  -- add python to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- correctly setup mason lsp / debug extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python-lsp-server",
        "black",
        "flake8",
        "pylint",
        "debugpy",
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "python",
    module = true,
    dependencies = { "Saecki/crates.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.pylint,
      })
    end,
  },

  -- debugger
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    opts = function()
      local mason_registry = require("mason-registry")
      local debugpy = mason_registry.get_package("debugpy")
      local python_path = debugpy:get_install_path() .. "/venv/bin/python"
      return python_path
    end,
    config = function(_, opts)
      require("dap-python").setup(opts[1])
    end,
  },
}
